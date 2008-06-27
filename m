From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Fri, 27 Jun 2008 10:22:26 +0200
Message-ID: <4864A342.4020900@scram.de>
References: <20080620084155.GA17701@pengutronix.de>
	<200806241615.08826.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806241615.08826.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

>> Bugfixes to the i2c-cpm driver
>>
>> - enable correct interrupts (I2CER_TXE instead of I2CER_BUSY)
>> - replace forgotten iic with i2c
>> - fix typo (devided)
>> - prefix debug-output on init with 0x and add frequency
>>
>> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Tested on a MPC8247 board. I have experienced I2C issues since migration from 
> ppc to powerpc. This patch seems to solve the problem.

What kind of problems have this been? In normal operation there shouldn't be
any I2CER_TXE interrupts being generated.

Thanks,
Jochen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
