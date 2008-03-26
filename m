From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/6] Blackfin I2C/TWI driver: Add repeat start
	feature to avoid break of a bundle of i2c master xfer operation.
Date: Wed, 26 Mar 2008 15:59:26 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA01B180A0@chinexm1.ad.analog.com>
References: <1205479360-25240-2-git-send-email-cooloney@kernel.org><20080324192045.2343293c@hyperion.delvare><0F1B54C89D5F954D8535DB252AF412FA01B17710@chinexm1.ad.analog.com>
	<20080325150428.6031264f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080325150428.6031264f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I just fixed rest issues in the twi driver according to your last
comments in
http://lists.lm-sensors.org/pipermail/i2c/2007-November/002121.html .
Bryan will send you the latest patch.

Thank you for your suggestion.

Sonic Zhang
 

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Tuesday, March 25, 2008 10:04 PM
To: Zhang, Sonic
Cc: Bryan Wu; i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Subject: Re: [PATCH 1/6] Blackfin I2C/TWI driver: Add repeat start
feature to avoid break of a bundle of i2c master xfer operation.

Hi Sonic,

On Tue, 25 Mar 2008 11:01:18 +0800, Zhang, Sonic wrote:
> I have already discussed your questions with you in attached email. 
> See bellow. The twi controller is designed to support SMBus protocol 
> in hardware. That's why we implement bfin_twi_smbus_xfer().

This is news to me, you did not tell this to me before. If there are
hardware optimizations for SMBus then indeed it makes sense to have
different code in the driver for I2C support and SMBus support.

Still, I had several objections to the patch that was submitted in
November 2007 (and resubmitted unchanged one week ago). I really would
like to see them addressed.

Thanks,
