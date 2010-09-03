From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: RE: [PATCH v2 2/2] i2c: QUP based bus driver for Qualcomm MSM
 chipsets
Date: Fri, 3 Sep 2010 10:38:08 +0200
Message-ID: <CEE6BB42CAD6E947908279175AF8470A026B35EA9D@EXDCVYMBSTM006.EQ1STM.local>
References: <1283470197-21148-1-git-send-email-kheitke@codeaurora.org>
 <1283470197-21148-3-git-send-email-kheitke@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283470197-21148-3-git-send-email-kheitke@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kenneth Heitke <kheitke@codeaurora.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Crane Cai <crane.cai@amd.com>, Samuel Ortiz <sameo@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

[Kenneth]

> From: Kenneth Heitke [mailto:kheitke@codeaurora.org]
> Subject: [PATCH v2 2/2] i2c: QUP based bus driver for Qualcomm MSM
> chipsets
> (...)
> +	dev->one_bit_t = USEC_PER_SEC/pdata->bus_freq;

Maybe you want to use DIV_ROUND_UP() from kernel.h here
to be on the safe side?

Yours,
Linus Walleij
