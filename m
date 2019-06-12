From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 02/34] gpu: drm: bridge: sii9234: simplify getting the
 adapter of a client
Date: Wed, 12 Jun 2019 16:04:10 +0200
Message-ID: <87d7a499-22b8-5e9f-8da2-54c83d1c4b2d@samsung.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
        <20190608105619.593-3-wsa+renesas@sang-engineering.com>
        <CGME20190608114101epcas3p4127647ce1c8224b4d777585bfa8e31d1@epcas3p4.samsung.com>
        <20190608114036.GA4786@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608114036.GA4786@pendragon.ideasonboard.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08.06.2019 13:40, Laurent Pinchart wrote:
> Hi Wolfram,
>
> Thank you for the patch.
>
> On Sat, Jun 08, 2019 at 12:55:41PM +0200, Wolfram Sang wrote:
>> We have a dedicated pointer for that, so use it. Much easier to read and
>> less computation involved.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>


Queued to drm-misc-next.


Laurent, for unknown reason patchwork does not collect yours tags, and
it is not the 1st time, added manually.


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>
>> ---
>>
>> Please apply to your subsystem tree.
>>
>>  drivers/gpu/drm/bridge/sii9234.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
>> index b36bbafb0e43..25d4ad8c7ad6 100644
>> --- a/drivers/gpu/drm/bridge/sii9234.c
>> +++ b/drivers/gpu/drm/bridge/sii9234.c
>> @@ -815,7 +815,7 @@ static irqreturn_t sii9234_irq_thread(int irq, void *data)
>>  static int sii9234_init_resources(struct sii9234 *ctx,
>>  				  struct i2c_client *client)
>>  {
>> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
>> +	struct i2c_adapter *adapter = client->adapter;
>>  	int ret;
>>  
>>  	if (!ctx->dev->of_node) {
>> @@ -897,7 +897,7 @@ static const struct drm_bridge_funcs sii9234_bridge_funcs = {
>>  static int sii9234_probe(struct i2c_client *client,
>>  			 const struct i2c_device_id *id)
>>  {
>> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
>> +	struct i2c_adapter *adapter = client->adapter;
>>  	struct sii9234 *ctx;
>>  	struct device *dev = &client->dev;
>>  	int ret;
