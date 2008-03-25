From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/6] Blackfin I2C/TWI driver: Add repeat start
 feature to avoid break of a bundle of i2c master xfer operation.
Date: Tue, 25 Mar 2008 15:04:28 +0100
Message-ID: <20080325150428.6031264f@hyperion.delvare>
References: <1205479360-25240-2-git-send-email-cooloney@kernel.org>
	<20080324192045.2343293c@hyperion.delvare>
	<0F1B54C89D5F954D8535DB252AF412FA01B17710@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA01B17710-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sonic,

On Tue, 25 Mar 2008 11:01:18 +0800, Zhang, Sonic wrote:
> I have already discussed your questions with you in attached email. See
> bellow. The twi controller is designed to support SMBus protocol in
> hardware. That's why we implement bfin_twi_smbus_xfer().

This is news to me, you did not tell this to me before. If there are
hardware optimizations for SMBus then indeed it makes sense to have
different code in the driver for I2C support and SMBus support.

Still, I had several objections to the patch that was submitted in
November 2007 (and resubmitted unchanged one week ago). I really would
like to see them addressed.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
