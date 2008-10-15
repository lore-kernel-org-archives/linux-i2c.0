From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Wed, 15 Oct 2008 15:57:13 -0700 (PDT)
Message-ID: <20081015.155713.44275434.davem@davemloft.net>
References: <20080821.024327.144744678.davem@davemloft.net>
	<20081015143321.7df02b35@hyperion.delvare>
	<20081015.143452.114860633.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015.143452.114860633.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Date: Wed, 15 Oct 2008 14:34:52 -0700 (PDT)

> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Date: Wed, 15 Oct 2008 14:33:21 +0200
> 
> > For another, with the introduction of I2C classes several years ago,
> > I2C device drivers should no longer probe random I2C adapters.  
> 
> Jean, they do, that's why I wrote this change.
> 
> > They should only probe adapters which share a class bit with them,
> 
> The pcf driver sets the class bit used by FAN and temperature sensors,
> so the I2C layer goes poking around all of the standard address
> locations each of those drivers list.
> 
> I don't want that to happen, ever.  I know exactly what address each
> and every I2C device sits at, so I don't want auto probing at all even
> even if the class bits match.

BTW, the powerpc folks want things the same exact way.

Look at the following change below which went into Linus's tree today.

Arguing against this is pointless.  With openfirmware device trees
describing exactly where every I2C device is, we want none of the
class based auto-probing stuff, we never ever want it.

Openfirmware platforms automatically trigger the device discovery
based upon the openfirmware device tree nodes.  None of the I2C
layer class based probing infrastructure is necessary nor wanted.

commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d
Author: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Date:   Wed Oct 8 11:36:42 2008 -0600

    i2c-mpc: suppress I2C device probing
    
    This patch suppresses I2C device probing by clearing the class field
    of the "struct i2c_adapter" for the MPC I2C bus adapters. Some board
    configurations which rely on probing must be fixed up by adding a
    proper I2C device node to the DTS file, like the TQM85xx modules.
    
    Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
    Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 27443f0..a9a45fc 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -312,7 +312,6 @@ static struct i2c_adapter mpc_ops = {
 	.name = "MPC adapter",
 	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
-	.class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.timeout = 1,
 };
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
