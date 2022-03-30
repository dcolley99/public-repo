import psycopg2
import os
import time
import random

counter = 0

while counter < 10:
    counter += 1
    os.system("aws rds reboot-db-instance --db-instance-identifier pgsql-research")
    time.sleep(120)  # wait for 2 minutes, give the reboot a chance to take place

    #  TEST 1 - SELECT WITH PREDICATES

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "SELECT  MAX(\"DateTimeStamp\") \
        FROM    \"controlRandom100k\" \
        WHERE   \"Category\" = 'E' "
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    SELECT  MAX(\"DateTimeStamp\") \
        FROM    \"controlRandom100k\" \
        WHERE   \"Category\" = ''E'' ' ) ) \
    , \
    runstats AS ( \
    SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements WHERE \"query\" like ('%DateTimeStamp%') \
    AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'controlRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'C PgSQL Test 1 100k SELECT WITH PREDICATES', " + str(counter) + ", \
            runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata "
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()

    # TEST 2 - SELECT WITHOUT PREDICATES

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "SELECT  MAX(\"DateTimeStamp\") \
        FROM    \"controlRandom100k\" "
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    SELECT  MAX(\"DateTimeStamp\") \
        FROM    \"controlRandom100k\" \
        ' ) ) \
    , \
    runstats AS ( \
    SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements WHERE \"query\" like ('%DateTimeStamp%') \
                              AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'controlRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'C PgSQL Test 2 100k SELECT WITHOUT PREDICATES', " + str(counter) + ", \
            runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata "
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()

    # TEST 3 - INSERTION, 100k

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "WITH nextval AS ( \
    SELECT MAX(\"UQID\") + 1 AS \"MAXUQID\" FROM \"controlRandom100k\" \
    ) \
    INSERT INTO \"controlRandom100k\" (\"UQID\",\"Category\",\"DateTimeStamp\") \
    SELECT \"MAXUQID\", 'F', NOW() + (RANDOM() * (INTERVAL '365 days') ) \
    FROM \"nextval\" "
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = " \
    WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    WITH nextval AS ( \
    SELECT MAX(\"UQID\") + 1 AS \"MAXUQID\" FROM \"controlRandom100k\" \
    ) \
    INSERT INTO \"controlRandom100k\" (\"UQID\",\"Category\",\"DateTimeStamp\") \
    SELECT \"MAXUQID\", ''F'', NOW() + (RANDOM() * (INTERVAL ''365 days'')) \
    FROM \"nextval\" ' \
     ) ) \
    , \
     runstats AS ( \
    SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements WHERE \"query\" like ('%DateTimeStamp%') \
                              AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'controlRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read,  \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'C PgSQL Test 3 100k INSERTION', " + str(counter) + ", \
           runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata"
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()
