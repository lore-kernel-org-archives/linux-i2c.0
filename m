From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/2] Add support for the S-35390A RTC chip.
Date: Fri, 4 Jan 2008 19:36:21 +0100
Message-ID: <20080104193621.1067b885@hyperion.delvare>
References: <1197751376-9767-1-git-send-email-byron.bbradley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1197751376-9767-1-git-send-email-byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, repvik-ifZ3rLY3rVnQT0dZR+AlfA@public.gmane.org, hvr-mXXj517/zsQ@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Byron,

On Sat, 15 Dec 2007 20:42:54 +0000, Byron Bradley wrote:
> These patches provide support the S-35390A RTC chip as used in the
> QNAP TS-109/TS-209 NAS devices. Along with a change from Andrew Morton
> this has already been accepted into the -mm tree but it was suggested
> that I send it to this list for an I2C review.
> 
> This chip is special in that the first 4-bits of the address are fixed
> to 0xc and the next 3-bits are used as a command so it takes up 8 addresses
> on the I2C bus.

What a weird design :(

> 0001 Add support for the S-35390A RTC chip.
> 0002 rtc-add-support-for-the-s-35390a-rtc-chip-fix
>         Written by Andrew Morton this replaces my bit-reversing function
>         with bitrev8().

Given that your original patch isn't merged in git yet, the preferred
approach is to merge the fixes in your patch before you resubmit it.
This makes further reviews easier.

-- 
Jean Delvare
