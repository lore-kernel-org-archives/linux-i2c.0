From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c-ibm_iic: Remove deprecated OCP style part of
	the driver
Date: Wed, 4 Jun 2008 21:33:18 +0200
Message-ID: <200806042133.18215.sr@denx.de>
References: <1212592932-24031-1-git-send-email-sr@denx.de>
	<20080604210400.0d7abb8e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604210400.0d7abb8e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Jean Delvare wrote:
> On Wed,  4 Jun 2008 17:22:12 +0200, Stefan Roese wrote:
> > The deprecated OCP style driver part is used by the "old" arch/ppc
> > platform. This platform is scheduled for removal in June/July this year.
> > This patch now removes the OCP driver part from the IBM I2C driver.
> >
> > Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ibm_iic.c |  181
> > -------------------------------------- 1 files changed, 0 insertions(+),
> > 181 deletions(-)
>
> Applied, queued for 2.6.27, thanks Stefan.

Thanks. I'll post some smaller follow-up patches probably tomorrow.

> BTW, would you happen to know if read-only EEPROMs such as SPD or EDID
> can be found on the i2c-ibm_iic adapters?

Yes. Some PPC4xx boards are equipped with DIMM modules. Those SPD EEPROM's are 
connected to the I2C bus controller by the i2c-ibm_iic driver.

Best regards,
Stefan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
