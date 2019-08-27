From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 3/3] i2c: bcm2835: Add full name of devicetree node to
 adapter name
Date: Tue, 27 Aug 2019 14:10:46 -0700
Message-ID: <1c42daa2-f7f7-baac-2d44-f9d86848d331@broadcom.com>
References: <1566925456-5928-1-git-send-email-wahrenst@gmx.net>
 <1566925456-5928-4-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566925456-5928-4-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Wolfram Sang <wsa@the-dreams.de>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 2019-08-27 10:04 a.m., Stefan Wahren wrote:
> Inspired by Lori Hikichi's patch for iproc, this adds the full name of
> the devicetree node to the adapter name. With the introduction of
> BCM2711 it's very difficult to distinguish between the multiple instances.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> =2D--
>   drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm=
> 2835.c
> index ab5502f..e01b2b5 100644
> =2D-- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -472,7 +472,8 @@ static int bcm2835_i2c_probe(struct platform_device *p=
> dev)
>   	i2c_set_adapdata(adap, i2c_dev);
>   	adap->owner =3D THIS_MODULE;
>   	adap->class =3D I2C_CLASS_DEPRECATED;
> -	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
> +	snprintf(adap->name, sizeof(adap->name), "bcm2835 (%s)",
> +		 of_node_full_name(pdev->dev.of_node));
>   	adap->algo =3D &bcm2835_i2c_algo;
>   	adap->dev.parent =3D &pdev->dev;
>   	adap->dev.of_node =3D pdev->dev.of_node;
> =2D-
> 2.7.4
>
