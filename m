From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-ibm_iic: Remove deprecated OCP style part of the
	driver
Date: Wed, 4 Jun 2008 21:04:00 +0200
Message-ID: <20080604210400.0d7abb8e@hyperion.delvare>
References: <1212592932-24031-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1212592932-24031-1-git-send-email-sr@denx.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Wed,  4 Jun 2008 17:22:12 +0200, Stefan Roese wrote:
> The deprecated OCP style driver part is used by the "old" arch/ppc
> platform. This platform is scheduled for removal in June/July this year.
> This patch now removes the OCP driver part from the IBM I2C driver.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c |  181 --------------------------------------
>  1 files changed, 0 insertions(+), 181 deletions(-)

Applied, queued for 2.6.27, thanks Stefan.

BTW, would you happen to know if read-only EEPROMs such as SPD or EDID
can be found on the i2c-ibm_iic adapters?

-- 
Jean Delvare
