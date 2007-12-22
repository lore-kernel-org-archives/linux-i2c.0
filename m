From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH POWERPC] i2c: adds support for i2c bus on Frescale CPM1/CPM2
 controllers
Date: Sat, 22 Dec 2007 10:59:08 +0100
Message-ID: <476CDFEC.1070506@scram.de>
References: <476C15BC.3090807@scram.de> <20071222001112.691b80c8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753962AbXLVJ6k@vger.kernel.org>
In-Reply-To: <20071222001112.691b80c8@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

Hi Vitaly,

> I had an attempt a while ago to do this but haven't had enough time to get it completed, so
> I am glad to see it finally picked up. There was some sort of discussion that time, you seem to have some of those points
> addressed but  something not, please
> check: http://lkml.org/lkml/2007/5/8/45
>
> (for instance, cpm_i2c_shutdown() and i2c_cpm_del_bus() are void because they cant' fail)
>   

I'll resend a fixed patch.

> Also, why this was directed to Scott? This is lm-sensors stuff and is
> Jean Delvare <khali@linux-fr.org> material..

Scott reviewed this driver last time and i hope to get some further 
comments from him. But thanks for adding
Jean as well.

Thanks,
Jochen

