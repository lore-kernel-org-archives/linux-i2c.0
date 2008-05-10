From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Sat, 10 May 2008 20:18:25 +0200
Message-ID: <20080510201825.489198d2@hyperion.delvare>
References: <200805012046.07885.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805012046.07885.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 1 May 2008 20:46:07 -0700, David Brownell wrote:
> Tighten error paths used by various other i2c adapters so they
> return real fault/errno codes instead of a literal "-1" (which
> is most often interpreted as "-EPERM").  Build tested.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> NOTE there are many other adapter drivers to audit and update; and
> they're not just within the drivers/i2c tree.  This patch is a PC
> oriented start on some bottom-up improvement of fault reporting.
> The i2c-gpio code looks be good too.
> 
>  drivers/i2c/algos/i2c-algo-bit.c      |   11 +++++---
>  drivers/i2c/busses/i2c-ali1535.c      |   22 +++++++---------
>  drivers/i2c/busses/i2c-ali1563.c      |    4 +--
>  drivers/i2c/busses/i2c-ali15x3.c      |   19 +++++++-------
>  drivers/i2c/busses/i2c-amd756-s4882.c |    4 +--
>  drivers/i2c/busses/i2c-amd756.c       |   18 +++++++------
>  drivers/i2c/busses/i2c-amd8111.c      |   44 +++++++++++++++++++++------------
>  drivers/i2c/busses/i2c-i801.c         |   45 +++++++++++++++++-----------------
>  drivers/i2c/busses/i2c-nforce2.c      |   25 +++++++++---------
>  drivers/i2c/busses/i2c-piix4.c        |   20 ++++++++-------
>  drivers/i2c/busses/i2c-sis5595.c      |   19 ++++++++------
>  drivers/i2c/busses/i2c-sis630.c       |   43 ++++++++++++++++++--------------
>  drivers/i2c/busses/i2c-sis96x.c       |   20 ++++++++-------
>  drivers/i2c/busses/i2c-stub.c         |    4 +--
>  drivers/i2c/busses/i2c-viapro.c       |   20 ++++++++-------
>  15 files changed, 176 insertions(+), 142 deletions(-)

I am in the process of reviewing and testing this patch. I think it
would help me if you could list your error value choices for the common
error conditions of I2C and SMBus controllers (bus busy, arbitration
lost, transaction timeout, etc.) With such a list I could check the
different drivers for consistency, and maybe this could even become
documentation for future driver authors.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
