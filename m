From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 33/34] staging: media: soc_camera: soc_mt9v022: simplify
 getting the adapter of a client
Date: Thu, 13 Jun 2019 11:54:22 +0200
Message-ID: <20190613095421.qmi7665txyszhkwn@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-34-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-34-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:56:12PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/staging/media/soc_camera/soc_mt9v022.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/soc_camera/soc_mt9v022.c b/drivers/staging/media/soc_camera/soc_mt9v022.c
> index e7e0d3d29499..1739a618846d 100644
> --- a/drivers/staging/media/soc_camera/soc_mt9v022.c
> +++ b/drivers/staging/media/soc_camera/soc_mt9v022.c
> @@ -883,7 +883,7 @@ static int mt9v022_probe(struct i2c_client *client,
>  {
>  	struct mt9v022 *mt9v022;
>  	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct mt9v022_platform_data *pdata;
>  	int ret;
>  
> -- 
> 2.19.1
> 
