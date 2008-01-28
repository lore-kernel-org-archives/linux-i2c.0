From: Jon Loeliger <jdl-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to i2c
	drivers
Date: Mon, 28 Jan 2008 11:10:55 -0600
Message-ID: <1201540252.24073.6.camel@ld0161-tx32>
References: <20080128144202.8410.14647.stgit@terra.home>
	<20080128144209.8410.37884.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080128144209.8410.37884.stgit-+J+k29bDNxlBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org" <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2008-01-28 at 08:42, Jon Smirl wrote:
> PowerPC device trees use a different naming convention than the Linux kernel.  Provide alias names for i2c drivers in order to allow them to be loaded by device tree name. The OF_ID macro ensures that the aliases are only present in powerpc builds and separated into their own namespace.
> 
> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Hi Jon,

Any chance we can have hard 70-ish column limited
log messages, please?

Thanks,
jdl



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
