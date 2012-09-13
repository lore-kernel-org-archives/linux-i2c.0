From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: (algo-pca) Fix chip reset function for PCA9665
Date: Thu, 13 Sep 2012 16:14:47 -0700
Message-ID: <CC77B638.1126D%tkavanagh@juniper.net>
References: <20120913134128.GA1343@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120913134128.GA1343-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

  Hopefully the information below explains the problem with the current pca9665_reset() function.

Regards,

Tom

Let's say mod1 has the following

typedef struct mod1_pca_data_ {
    int                   number;
    unsigned int          bus;
    char                  name[50];
    i2c_algo_pca_data    *adap;
} mod1_pca_data_t;

static struct i2c_algo_pca_data mod1_pca_algo_data = {
    .write_byte             = mod1_writebyte,
    .read_byte              = mod1_readbyte,
    .wait_for_completion    = mod1_pca_waitforcompletion,
    .reset_chip             = mod1_pca_resetchip,
    .i2c_clock              = 400000,
};

/*
 *
 */
static struct i2c_adapter mod1_pca_adapter = {
    .owner          = THIS_MODULE,
    .class          = I2C_CLASS_HWMON,
    .algo_data      = &mod1_pca_algo_data,
    .name           = "Mod1 PCA Bus Adapter",
    .timeout        = HZ,
};


void mod1_pca_attach(struct device *dev, mod1_data_t *mod1_data)
{
    mod1_pca_algo_data.data = mod1_data;

    mod1_data->adap = &mod1_pca_adapter;

    mod1_data->adap->dev.parent  = dev;

    i2c_pca_add_bus(mod1_data->adap);
}


Within the i2c-algo-pca module, all calls to pca_outw(adap) and pca_inw(adap) will be done with an input parameter of type i2c_algo_pca_data.  These will intern call mod1's read_byte and write byte functions and pass in adap->data as the first parameter.  This data pointer is of type mod1_pca_data_t * in this example.

Now with the pca9665_reset() function, the i2c-algo-pca module sets the mod1's reset_chip function pointer to pca9665_reset.  When pca_reset(adap) is called, the input parameter is of type i2c_algo_pca_data as expected.  Then pca_reset() calls adap->reset_chip (pca9665_reset) with the first parameter being adap->data.  This parameter is of type mod1_pca_data_t * in this example.  The problem comes from the fact that pca9665_reset(void *pd) is expecting the parameter to be of type i2c_algp_pca_data:

static void pca9665_reset(void *pd)
{
    struct i2c_algo_pca_data *adap = pd;
    pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
    pca_outw(adap, I2C_PCA_IND, 0xA5);
    pca_outw(adap, I2C_PCA_IND, 0x5A);
}

All calls to pca_outw(adap) in this function are passing in a pointer to mod1_pca_data_t and not i2c_algo_pca_data which in turn causes the kernel to panic when the pca_outw(adap) macro tries to access adap->write_byte().




On 9/13/12 6:41 AM, "Guenter Roeck" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org<mailto:linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>> wrote:

On Thu, Sep 13, 2012 at 12:14:23PM +0200, Wolfram Sang wrote:
On Wed, Sep 12, 2012 at 08:39:50PM -0700, Guenter Roeck wrote:
> From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org<mailto:tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>>
>
> The parameter passed to pca9665_reset is adap->data, not adap. Unless
> adap->data happens to point back to adap, this can result in a kernel panic.
Like every write and read to a register which uses the same assumption
AFAICS?
You lost me there. Other reset functions are aware of and use the passed parameter
(adap->data). pca9665_reset overwrites the original reset function with
pca_data->reset_chip = pca9665_reset;
but not ->data (which it can't overwrite since it is used by the read_byte and
write_byte functions).

static void pca9665_reset(void *pd)
struct i2c_algo_pca_data *adap = pd;
static void i2c_pca_pf_resetchip(void *pd)
struct i2c_pca_pf_data *i2c = pd;
static int i2c_pca_pf_readbyte32(void *pd, int reg)
struct i2c_pca_pf_data *i2c = pd;

Guenter
