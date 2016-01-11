From: Rongrong Zou <zourongrong@gmail.com>
Subject: mutex_lock in designware-i2c
Date: Mon, 11 Jan 2016 19:12:10 +0800
Message-ID: <56938E0A.5080303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36532 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbcAKLMQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Jan 2016 06:12:16 -0500
Received: by mail-pf0-f172.google.com with SMTP id n128so43407351pfn.3
        for <linux-i2c@vger.kernel.org>; Mon, 11 Jan 2016 03:12:16 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: baruch@tkos.co.il
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi, baruch

I found a mutex lock in dw_i2c_dev for each adapter,
struct dw_i2c_dev {
         struct device           *dev;
         void __iomem            *base;
         struct completion       cmd_complete;
         struct mutex            lock;
         struct clk              *clk;

but there is another lock: adapter->bus_lock, this lock is also
for each adapter, why we need both of them ?

Regards,

Rongrong
