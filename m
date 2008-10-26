From: Felix Radensky <felix-L1vi/lXTdtvUXIAPrk8Z/A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: virtual i2c adapter support
Date: Sun, 26 Oct 2008 23:53:55 +0200
Message-ID: <4904E6F3.50609@embedded-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: giometti-k2GhghHVRtY@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Rodolfo

I've tried your patches with linux-2.6.27 kernel running
on custom board with 460EX PowerPC. This board has
two i2c buses and pca9548 switch on bus 0.

The 954x driver (compiled into the kernel) creates 8
virtual buses just fine.  However devices behind the
mux are not detected if I use the "recommended" way
of doing things.

I have RTC (ds1338) and temp sensor (ds1625) on mux
channel 4 (i.e virtual bus 6). What I did initially to add
the following code to board init code:

struct board_i2c_info {
    int bus;
    int addr;
    char *id;
};

static struct board_i2c_info board_i2c_devices[] = {
    /* Bus  Addr       ID  */
    {6,     0x68,    "ds1338"},
    {6,     0x49,    "ds1625"},
};

static int board_i2c_init(void)
{
    int i;

    for (i = 0; i < ARRAY_SIZE(board_i2c_devices); i++) {
        struct i2c_board_info info = {};

        info.irq = -1;
        info.addr = board_i2c_devices[i].addr;
        if (strlcpy(info.type, board_i2c_devices[i].id,
                I2C_NAME_SIZE) >= I2C_NAME_SIZE)
            return -ENOMEM;

        i2c_register_board_info(board_i2c_devices[i].bus, &info, 1);
    }
}
arch_initcall(board_i2c_init);

This code is invoked by kernel before i2c bus and mux detection,
but, as I said, RTC and sensor are not identified.

If I invoke the following code  after creation of virtual
adapters, things start working, but I don't like this solution

static int board_i2c_init(void)
{
    int i;
   
    for (i = 0; i < ARRAY_SIZE(board_i2c_devices); i++) {
        struct i2c_board_info info = {};
        struct i2c_adapter *adap;
 
       info.irq = -1;
        info.addr = board_i2c_devices[i].addr;
        if (strlcpy(info.type, board_i2c_devices[i].id,
                I2C_NAME_SIZE) >= I2C_NAME_SIZE)
            return -ENOMEM;

        adap = i2c_get_adapter(board_i2c_devices[i].bus);
        i2c_new_device(adap, &info);
    }
}

My question is: how can I register board i2c devices behind
the mux in board init code, and make them properly identified
when relevant drivers are loaded.

Thanks a lot.

Felix.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
