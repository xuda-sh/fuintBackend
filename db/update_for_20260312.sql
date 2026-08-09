/*Table structure for table `mt_user_tag` */

DROP TABLE IF EXISTS `mt_user_tag`;

CREATE TABLE `mt_user_tag` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `MERCHANT_ID` INT NOT NULL DEFAULT '0' COMMENT '所属商户ID',
  `NAME` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '标签名称',
  `COLOR` VARCHAR(20) DEFAULT '#1890ff' COMMENT '标签颜色',
  `SORT` INT DEFAULT '0' COMMENT '排序',
  `DESCRIPTION` VARCHAR(500) DEFAULT '' COMMENT '标签描述',
  `CREATE_TIME` DATETIME DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` DATETIME DEFAULT NULL COMMENT '更新时间',
  `OPERATOR` VARCHAR(30) DEFAULT '' COMMENT '最后操作人',
  `STATUS` CHAR(1) DEFAULT 'A' COMMENT '状态，A：激活；N：禁用；D：删除',
  PRIMARY KEY (`ID`),
  KEY `IDX_MERCHANT_ID` (`MERCHANT_ID`),
  KEY `IDX_MERCHANT_NAME` (`MERCHANT_ID`, `NAME`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='会员标签表';

/*Table structure for table `mt_user_tag_relation` */

DROP TABLE IF EXISTS `mt_user_tag_relation`;

CREATE TABLE `mt_user_tag_relation` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `USER_ID` INT NOT NULL DEFAULT '0' COMMENT '会员ID',
  `TAG_ID` INT NOT NULL DEFAULT '0' COMMENT '标签ID',
  `CREATE_TIME` DATETIME DEFAULT NULL COMMENT '创建时间',
  `OPERATOR` VARCHAR(30) DEFAULT '' COMMENT '操作人',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_USER_TAG` (`USER_ID`, `TAG_ID`),
  KEY `IDX_USER_ID` (`USER_ID`),
  KEY `IDX_TAG_ID` (`TAG_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='会员标签关联表';

/*Table structure for table `mt_user_tag_rule` */

DROP TABLE IF EXISTS `mt_user_tag_rule`;

CREATE TABLE `mt_user_tag_rule` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `MERCHANT_ID` INT NOT NULL DEFAULT '0' COMMENT '所属商户ID',
  `TAG_ID` INT NOT NULL COMMENT '关联标签ID',
  `RULE_NAME` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `RULE_TYPE` VARCHAR(30) NOT NULL COMMENT '规则类型：consume_count-消费次数, consume_amount-消费金额, last_consume-最后消费时间, register_time-注册时间, single_order_amount-单笔订单金额, avg_order_amount-平均订单金额, total_order_count-累计订单数, point_balance-积分余额',
  `TIME_RANGE` VARCHAR(20) DEFAULT NULL COMMENT '时间范围：1month-1个月, 3month-3个月, 6month-6个月, 1year-1年, all-全部',
  `OPERATOR_TYPE` VARCHAR(20) NOT NULL COMMENT '操作符：gt-大于, gte-大于等于, lt-小于, lte-小于等于, eq-等于, between-区间, ne-不等于',
  `THRESHOLD_VALUE` DECIMAL(10,2) DEFAULT '0.00' COMMENT '阈值',
  `THRESHOLD_MAX` DECIMAL(10,2) DEFAULT NULL COMMENT '最大值（区间用）',
  `DESCRIPTION` VARCHAR(500) DEFAULT '' COMMENT '规则描述',
  `IS_AUTO` CHAR(1) DEFAULT 'Y' COMMENT '是否自动执行：Y-是, N-否',
  `PRIORITY` INT DEFAULT '0' COMMENT '优先级',
  `CREATE_TIME` DATETIME DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` DATETIME DEFAULT NULL COMMENT '更新时间',
  `OPERATOR` VARCHAR(30) DEFAULT '' COMMENT '最后操作人',
  `STATUS` CHAR(1) DEFAULT 'A' COMMENT '状态，A：激活；N：禁用；D：删除',
  PRIMARY KEY (`ID`),
  KEY `IDX_MERCHANT_ID` (`MERCHANT_ID`),
  KEY `IDX_TAG_ID` (`TAG_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='会员标签规则表';

/*Table structure for table `mt_user_tag_rule_log` */

DROP TABLE IF EXISTS `mt_user_tag_rule_log`;

CREATE TABLE `mt_user_tag_rule_log` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `RULE_ID` INT NOT NULL COMMENT '规则ID',
  `USER_ID` INT NOT NULL COMMENT '会员ID',
  `EXECUTE_TIME` DATETIME DEFAULT NULL COMMENT '执行时间',
  `EXECUTE_RESULT` CHAR(1) DEFAULT 'Y' COMMENT '执行结果：Y-成功, N-失败',
  `REMARK` VARCHAR(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `IDX_RULE_ID` (`RULE_ID`),
  KEY `IDX_USER_ID` (`USER_ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='标签规则执行记录表';
