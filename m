From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/9] iio: imu: inv_mpu6050: Fix Yoda conditions
Date: Sun, 21 Feb 2016 20:38:00 +0000
Message-ID: <56CA2028.90603@kernel.org>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-3-git-send-email-daniel.baluta@intel.com>
 <CAKv63us92Epe0go9JGNScbeOepg3_j8RyW9w2qgN01Jvnj3sUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKv63us92Epe0go9JGNScbeOepg3_j8RyW9w2qgN01Jvnj3sUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org, Adriana Reus <adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mwelling-EkmVulN54Sk@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 19/02/16 09:09, Crt Mori wrote:
> This is quite trivial.
> 
> Acked-by: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Applied.
> 
> On 18 February 2016 at 16:53, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> This fixes the following checkpatch warning:
>>         * WARNING: Comparisons should place the constant
>>           on the right side of the test
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 84e014c..c550ebb 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -84,7 +84,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>>          * clock source be switched to gyro. Otherwise, it must be set to
>>          * internal clock
>>          */
>> -       if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>> +       if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
>>                 result = regmap_read(st->map, st->reg->pwr_mgmt_1, &mgmt_1);
>>                 if (result)
>>                         return result;
>> @@ -92,7 +92,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>>                 mgmt_1 &= ~INV_MPU6050_BIT_CLK_MASK;
>>         }
>>
>> -       if ((INV_MPU6050_BIT_PWR_GYRO_STBY == mask) && (!en)) {
>> +       if ((mask == INV_MPU6050_BIT_PWR_GYRO_STBY) && (!en)) {
>>                 /*
>>                  * turning off gyro requires switch to internal clock first.
>>                  * Then turn off gyro engine
>> @@ -117,7 +117,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>>         if (en) {
>>                 /* Wait for output stabilize */
>>                 msleep(INV_MPU6050_TEMP_UP_TIME);
>> -               if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>> +               if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
>>                         /* switch internal clock to PLL */
>>                         mgmt_1 |= INV_CLK_PLL;
>>                         result = regmap_write(st->map,
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> index 1fc5fd9..441080b 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> @@ -168,7 +168,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>>
>>                 result = kfifo_out(&st->timestamps, &timestamp, 1);
>>                 /* when there is no timestamp, put timestamp as 0 */
>> -               if (0 == result)
>> +               if (result == 0)
>>                         timestamp = 0;
>>
>>                 result = iio_push_to_buffers_with_timestamp(indio_dev, data,
>> --
>> 2.5.0
>>
