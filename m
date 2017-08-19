From: isely@isely.net
Subject: Re: [PATCH 2/2] [media] usb: make i2c_algorithm const
Date: Sat, 19 Aug 2017 15:15:02 -0500 (CDT)
Message-ID: <alpine.DEB.2.11.1708191514360.27909@lochley.isely.net>
References: <1503072418-6887-1-git-send-email-bhumirks@gmail.com>
 <1503072418-6887-3-git-send-email-bhumirks@gmail.com>
Reply-To: Mike Isely at pobox <isely@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1503072418-6887-3-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: gxt@mprc.pku.edu.cn, wsa@the-dreams.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vz@mleia.com, julia.lawall@lip6.fr, linux-i2c@vger.kernel.org, slemieux.tyco@gmail.com, mchehab@kernel.org, Mike Isely at pobox <isely@pobox.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Acked-by: Mike Isely <isely@pobox.com>

On Fri, 18 Aug 2017, Bhumika Goyal wrote:

> Make these const as they are only used in a copy operation or
> are stored in the algo field of i2c_adapter structure, which is const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/media/usb/au0828/au0828-i2c.c        | 2 +-
>  drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/au0828/au0828-i2c.c b/drivers/media/usb/au0828/au0828-i2c.c
> index 42b352b..a028e36 100644
> --- a/drivers/media/usb/au0828/au0828-i2c.c
> +++ b/drivers/media/usb/au0828/au0828-i2c.c
> @@ -329,7 +329,7 @@ static u32 au0828_functionality(struct i2c_adapter *adap)
>  	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
>  }
>  
> -static struct i2c_algorithm au0828_i2c_algo_template = {
> +static const struct i2c_algorithm au0828_i2c_algo_template = {
>  	.master_xfer	= i2c_xfer,
>  	.functionality	= au0828_functionality,
>  };
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
> index 20a52b7..cfa8fbe 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
> @@ -514,7 +514,7 @@ static u32 pvr2_i2c_functionality(struct i2c_adapter *adap)
>  	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
>  }
>  
> -static struct i2c_algorithm pvr2_i2c_algo_template = {
> +static const struct i2c_algorithm pvr2_i2c_algo_template = {
>  	.master_xfer   = pvr2_i2c_xfer,
>  	.functionality = pvr2_i2c_functionality,
>  };
> 

-- 

Mike Isely
isely @ isely (dot) net
PGP: 03 54 43 4D 75 E5 CC 92 71 16 01 E2 B5 F5 C1 E8
