From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Fri, 4 Jan 2008 23:16:33 +0100
Message-ID: <20080104231633.135f2875@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712281230.17840.david-b@pacbell.net>
	<57e2b00712281645y70f6ec74s57945dc53f113ec8@mail.gmail.com>
	<200712291905.15160.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200712291905.15160.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 29 Dec 2007 19:05:14 -0800, David Brownell wrote:
> Remove further duplication between i2c core and driver model:  the
> per-adapter list of clients (adapter->clients,  client->list) and
> its lock (adapter->clist_lock) duplicate adapter->dev.children.
>  
> LIGHTLY TESTED ... goes on top of two patches from Jean's I2C queue,
> 
> 	i2c-remove-redundant-i2c_adapter-list.patch
> 	i2c-remove-redundant-i2c_driver-list.patch
> 
> Continuing in that naming scheme, this might be called
> 
> 	i2c-remove-redundant-i2c_client-list.patch
> 
> ---
>  drivers/i2c/i2c-core.c |  189 ++++++++++++++++++++++---------------------------
>  drivers/i2c/i2c-dev.c  |   33 ++++----
>  include/linux/i2c.h    |    4 -
>  3 files changed, 102 insertions(+), 124 deletions(-)

This breaks drivers/media/video/mxb.c, drivers/media/video/dpc7146.c
and drivers/media/video/tvmixer.c. These 3 drivers walk the clients
list that your patch wants to remove. I guess that we need to replace
their code by something equivalent that would walk the driver model's
children list instead of i2c-core's internal one?

-- 
Jean Delvare
