From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: Add MAINTAINER entry for i2c-cpm.
Date: Wed, 4 Jun 2008 08:17:53 +0200
Message-ID: <20080604081753.6830aca8@hyperion.delvare>
References: <4845A756.6010407@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <4845A756.6010407@scram.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jochen Friedrich <jochen@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 03 Jun 2008 22:19:34 +0200, Jochen Friedrich wrote:
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  MAINTAINERS |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a6d2ca..bdfc7bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1659,6 +1659,13 @@ L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
>  W:	http://linux-fbdev.sourceforge.net/
>  S:	Maintained
>  
> +FREESCALE I2C CPM DRIVER
> +P:	Jochen Friedrich
> +M:	jochen@scram.de
> +L:	linuxppc-dev@ozlabs.org
> +L:	i2c@lm-sensors.org
> +S:	Maintained
> +
>  FREESCALE DMA DRIVER
>  P:	Li Yang
>  M:	leoli@freescale.com

Applied, thanks.

-- 
Jean Delvare
