From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
 pca-algorithm
Date: Wed, 12 Mar 2008 11:43:26 +0100
Message-ID: <20080312114326.7ab11c06@hyperion.delvare>
References: <20080206202056.364404622@pengutronix.de>
	<20080206203037.228001815@pengutronix.de>
	<20080212225306.4cf2bd74@hyperion.delvare>
	<fqrob6$3e6$1@ger.gmane.org>
	<20080308111337.440a7c83@hyperion.delvare>
	<20080310112640.GB12128@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080310112640.GB12128-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram:

Just noticed the following warnings on x86_64:
drivers/i2c/busses/i2c-pca-platform.c: In function "i2c_pca_pf_probe":
drivers/i2c/busses/i2c-pca-platform.c:181: warning: format "%08x" expects type "unsigned int", but argument 2 has type "resource_size_t"
drivers/i2c/busses/i2c-pca-platform.c:186: warning: format "%08x" expects type "unsigned int", but argument 4 has type "resource_size_t"
drivers/i2c/busses/i2c-pca-platform.c:186: warning: format "%08x" expects type "unsigned int", but argument 4 has type "resource_size_t"

Please fix in next iteration.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
