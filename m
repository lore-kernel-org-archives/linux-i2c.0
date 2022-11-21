Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB85C433FE
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Nov 2022 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKUJuJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Nov 2022 04:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiKUJtl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Nov 2022 04:49:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185EC66;
        Mon, 21 Nov 2022 01:49:41 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8p7px031223;
        Mon, 21 Nov 2022 03:49:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=0yjhMhm9K1LG/TVZpa0MLYkDxl5Hj56fVFryVLoRst0=;
 b=BX5mlAFS+0vTloky8YFHdK4ZnYdS44DRSG918tTu/2wHLGLxjmJgMMvgT78f5QxKCBFV
 5oUcPXFmw+PbhKoGTUZ0rLvDTdrycMdslYCo9rVHVIwQn1PUhUhUJbb+0QL7juJeuMOw
 fKFg/XwktA8MQ7AtYVdVRhpGOzxl7d17cKJGZN4En9YtiWJSEwBwzf5TJiDgYRU94h5j
 aWbkMQAadq7Ht/273mpfD7QgwJ/tU9tz1fsPGz9pX5e3j7ZImrB84rv+DkyM7CYeKETC
 0aQ/OvHnL+IJZU41Jm1Iyvj1TAblphbmWE4qYZaMrhe8VgU2jasydzr+IIyGf7/HDMO+ +g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6syf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 03:49:29 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 21 Nov
 2022 03:49:27 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 21 Nov 2022 03:49:27 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D819B12;
        Mon, 21 Nov 2022 09:49:27 +0000 (UTC)
Date:   Mon, 21 Nov 2022 09:49:27 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
CC:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        <linux-i2c@vger.kernel.org>, <kernel@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 479/606] mfd: wm8350-i2c: Convert to i2c's .probe_new()
Message-ID: <20221121094927.GR10437@ediswmail.ad.cirrus.com>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-480-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-480-uwe@kleine-koenig.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 3usTdCm58wPk6ITPEWLyk8oySN6SvcAC
X-Proofpoint-GUID: 3usTdCm58wPk6ITPEWLyk8oySN6SvcAC
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Nov 18, 2022 at 11:43:33PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
