
drop table if exists transactions;
drop table if exists categories;

create table transactions(
  id               integer,
  acct_owner       varchar(80),
  acct_name        varchar(80),
  acct_type        varchar(80),
  date             varchar(80),
  amount           real,
  number           varchar(80),
  cleared          varchar(80),
  payee            varchar(80),
  category         varchar(80),
  memo             varchar(80),
  split1_amount    real,
  split1_category  varchar(80),
  split1_memo      real,
  split2_amount    varchar(80),
  split2_category  varchar(80),
  split2_memo      varchar(80),
  split3_amount    real,
  split3_category  varchar(80),
  split3_memo      varchar(80),
  address1         varchar(80),
  address2         varchar(80),
  address3         varchar(80),
  address4         varchar(80),
  address5         varchar(80),
  address6         varchar(80),
  balance          varchar(80),
  eol_ind          char(1)
);

create table categories(
  id       integer,
  name     varchar(80)
);

.separator '^'

.import private/qiflib_transactions.txt transactions
.import private/qiflib_categories.txt   categories

