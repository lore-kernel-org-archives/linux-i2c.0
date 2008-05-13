From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: new style i2c client problem: probe () is not called
Date: Tue, 13 May 2008 14:13:37 +0200
Message-ID: <20080513141337.20068339@hyperion.delvare>
References: <g0bqa9$b3$1@ger.gmane.org> <20080513104921.GA4485@pengutronix.de>
	<g0bub0$eqh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <g0bub0$eqh$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Darius,

On Tue, 13 May 2008 14:29:03 +0300, Darius wrote:
> I attach simplified i2c code part from my driver above:
> 
> ---------------------------------------------------------------------------------------------------------
> 
> struct ov7670 {
> 	struct i2c_client *client;
> };
> 
> static int ov7670_probe(struct i2c_client *client, const struct 
> i2c_device_id *did)
> {
> 	struct ov7670 *ov7670;
> 	struct i2c_adapter *adapter =to_i2c_adapter(client->dev.parent);
> 	int ret;
> 
> 	printk ("OV7670: error1\n");
> 
> 	if (!i2c_check_functionality(adapter,I2C_FUNC_SMBUS_WORD_DATA)){
> 		return -EIO;
> 	}
> 	
> 	ov7670 = kzalloc(sizeof(struct ov7670), GFP_KERNEL);
> 	if (!ov7670)
> 		return -ENOMEM;
> 	ov7670->client = client;
> 	i2c_set_clientdata(client, ov7670);
> 	return 0;
> }
> 
> static int ov7670_remove(struct i2c_client *client)
> {
> 	struct ov7670 *ov7670 = i2c_get_clientdata(client);
> 	struct i2c_adapter *adapter =to_i2c_adapter(client->dev.parent);
> 	kfree(ov7670);
> 	return 0;
> }
> 
> static const struct i2c_device_id ov7670_id[] = {
> 	{ "ov7670", 0 },
> 	{ }
> };
> MODULE_DEVICE_TABLE(i2c, ov7670_id);
> 
> static struct i2c_driver ov7670_i2c_driver = {
> 	.driver = 	
> 			{
> 				.name = "ov7670",
> 			},
> 	.probe		= ov7670_probe,
> 	.remove		= ov7670_remove,
> 	.id_table	= ov7670_id,
> };
> 
> static int __init ov7670_init(void)
> {
> 	printk ("OV7670: driver init\n");
> 	return i2c_add_driver(&ov7670_i2c_driver);
> }
> 
> static void __exit ov7670_exit(void)
> {
> 	printk ("OV7670: driver exit\n");	
> 	i2c_del_driver(&ov7670_i2c_driver);
> }
> 
> module_init(ov7670_init);
> module_exit(ov7670_exit);
> 
> 
> -------------------------------------------------------------------------------------------
> 
> And piece from board init:
> 
> ------------------------------------------------------------------------------------------
> 
> static struct i2c_board_info __initdata mx1ads_i2c_devices[] = {
> 	{
> 		I2C_BOARD_INFO("ov7670", 0x42),
> 	}
> };
> 
> <...>
> i2c_register_board_info(0,mx1ads_i2c_devices,ARRAY_SIZE(mx1ads_i2c_devices));
> <...>

This code looks OK to me. But which driver handles i2c bus 0? Does your
platform code create i2c bus 0? i2c-code will instantiate the ov7670
i2c device when i2c bus 0 is created by i2c_add_numbered_adapter(). So
if you don't see it created, I suspect that i2c bus 0 itself is never
registered.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
