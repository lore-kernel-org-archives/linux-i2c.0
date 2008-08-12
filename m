From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add VX800/VX820 support to i2c-viapro
Date: Tue, 12 Aug 2008 18:41:21 +0200
Message-ID: <20080812184121.7794675a@hyperion.delvare>
References: <489F3E6D.1010509@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <489F3E6D.1010509-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Cc: BruceChang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, bari <bari-LYzr9vXrEAJBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rudolf,

On Sun, 10 Aug 2008 21:15:57 +0200, Rudolf Marek wrote:
> Hello,
> 
> Thanks to new datasheets published on http://linux.via.com.tw we can now add 
> support for VX800/VX820 chipsets.
> 
> If anyone has the hardware, please test the patch in attachment. Some simple 
> test with i2cdump should be enough the hardware controller is same as on other 
> chipsets.
> 
> Signed-off-by: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

Thanks. I've queued this patch for 2.6.28, so it's in linux-next now. I
hope we can get some testing feedback in the next weeks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
