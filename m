From: Felix Radensky <felix-L1vi/lXTdtvUXIAPrk8Z/A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: virtual i2c adapter support
Date: Mon, 27 Oct 2008 13:31:25 +0200
Message-ID: <4905A68D.7040708@embedded-sol.com>
References: <4904E6F3.50609@embedded-sol.com> <20081027082025.GC11339@tekkaman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081027082025.GC11339@tekkaman>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Rodolfo

Rodolfo Giometti wrote:
> On Sun, Oct 26, 2008 at 11:53:55PM +0200, Felix Radensky wrote:
>   
>> Hi, Rodolfo
>>
>> I've tried your patches with linux-2.6.27 kernel running
>> on custom board with 460EX PowerPC. This board has
>> two i2c buses and pca9548 switch on bus 0.
>>     
>
> Please, consider thay my patch has been *not* accepted into main line
> due a mutex problem... :'(
>
>   
I didn't find any discussion on the mailing list. What mutex problem 
exactly ?

I find your patches very useful, and the concept of virtual buses very 
elegant.
Hopefully you can rework your patches and get them into mainline. I'm 
willing
to test new patch versions.
>> My question is: how can I register board i2c devices behind
>> the mux in board init code, and make them properly identified
>> when relevant drivers are loaded.
>>     
>
> I have just defined the i2c devices behind the mux as connected to the
> new virtual adapters:
>
> static int wr1100_adap_ids[] = {
>         2, 3,
> };
>
> static struct pca954x_platform_data wr1100_i2cmux_adap_ids = {
>         .adap_ids       = wr1100_adap_ids,
>         .len            = ARRAY_SIZE(wr1100_adap_ids),
> };
>
> static struct i2c_board_info __initdata wr1100_i2c_devices[] = {
>         {
>                 I2C_BOARD_INFO("pca9540", 0x70),
>                 .platform_data = &wr1100_i2cmux_adap_ids,
>         },
> };
>
> static struct i2c_board_info __initdata wr1100_i2c_mux_devices[] = {
>         {
>                 I2C_BOARD_INFO("bq27200", 0x55),
>         },
> };
>
> Then into machine startup code:
>
>         i2c_register_board_info(0, wr1100_i2c_devices,
>                                         ARRAY_SIZE(wr1100_i2c_devices));
>         i2c_register_board_info(2, wr1100_i2c_mux_devices,
>                                         ARRAY_SIZE(wr1100_i2c_mux_devices));
>         i2c_register_board_info(3, wr1100_i2c_mux_devices,
>                                         ARRAY_SIZE(wr1100_i2c_mux_devices));
>
>   
That works fine in my setup too. Thanks a lot for your help !!!
> Ciao,
>
> Rodolfo
>
>   
Felix.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
