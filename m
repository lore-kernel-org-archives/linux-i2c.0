From: =?utf-8?Q?=C3=89meric?= Vigier
	<emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: Re: how to gracefully unload an i2c driver if chip not detected?
Date: Sat, 20 Apr 2013 23:38:34 -0400 (EDT)
Message-ID: <228256972.786837.1366515514850.JavaMail.root@mail>
References: <20130409092625.GD3624@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130409092625.GD3624-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


----- Mail original -----
> De: "Wolfram Sang" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> =C3=80: "=C3=89meric Vigier" <emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Envoy=C3=A9: Mardi 9 Avril 2013 05:26:25
> Objet: Re: how to gracefully unload an i2c driver if chip not detecte=
d?
>=20
>=20
> > I recently changed the sensor on my board. Leading to kernel crash
> > when entering suspend. Thanks to "no_console_suspend" cmdline
> > argument, I found out that the suspend function of the "absent"
> > chip
> > gets called. It tries to take a mutex which has been freed in
> > probe's
> > "device not found" fallback code. Leading to kernel panic.
>=20
> Can we have the full driver? The snipplet is not enough.

Here you go:

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/input.h>
#include <linux/pm.h>
#include <linux/init.h>
#include <linux/kthread.h>
#include <linux/mutex.h>
#include <linux/platform_device.h>
#include <linux/workqueue.h>
#include <linux/i2c.h>
#include <linux/i2c/vcnl4010.h>
#include <linux/gpio.h>

#define VCNL4010_DEBUG 1

#define DEVICE_NAME "vcnl4010"
#define DRIVER_NAME "vcnl4010"

#define VCNL4010_CMD_REG 0x80
#define VCNL4010_PROD_ID_VER 0x81
#define VCNL4010_PROX_RATE 0X82
#define VCNL4010_IR_LED_CURR 0x83
#define VCNL4010_AMB_LIGHT_PARAM 0x84
#define VCNL4010_MSB_AMB_LIGHT_RESULT 0x85
#define VCNL4010_LSB_AMB_LIGHT_RESULT 0x86
#define VCNL4010_MSB_PROX_MEASURE_RESULT 0x87
#define VCNL4010_LSB_PROX_MEASURE_RESULT 0x88
#define VCNL4010_INTERRUPT_CTRL 0x89
#define VCNL4010_MSB_LOW_THRESHOLD 0x8A
#define VCNL4010_LSB_LOW_THRESHOLD 0x8B
#define VCNL4010_MSB_HIGH_THRESHOLD 0x8C
#define VCNL4010_LSB_HIGH_THRESHOLD 0x8D
#define VCNL4010_INTERRUPT_STATUS 0x8E
#define VCNL4010_PROX_MODU_TIMING_ADJ 0x8F

typedef enum {eNear, eFar, eNone} vcnl4010InterruptState;
#define VCNL4010_INT_PROX_READY 0x08
#define VCNL4010_INT_ALS_READY  0x04
#define VCNL4010_INT_THRES_LOW  0x02
#define VCNL4010_INT_THRES_HI   0x01

#define VCNL4010_FAR_DISTANCE 10

struct vcnl4010_data
{
    struct vcnl4010_platform_data *pdata;
    struct i2c_client *client;
    struct input_dev *input_dev;
    struct delayed_work wq;
    struct mutex lock;
    uint32_t self_refresh_poll_rate;
    vcnl4010InterruptState last_interrupt_state;
    uint16_t prox_offset;
    uint16_t threshold_low;
    uint16_t threshold_hi;
};

static struct task_struct *proximity_intr;

//static uint32_t prox_debug;
//module_param(prox_debug, uint, 0664);
//module_param_named(vcnl4010_debug, prox_debug, uint, 0664);
//MODULE_PARM_DESC(vcnl4010_debug, "VCNL4010 Debug");

#ifdef VCNL4010_DEBUG
struct vcnl4010_reg
{
    const char *name;
    uint8_t reg;
    int writeable;
} vcnl4010_regs[] =3D {
    { "CMD_REG",                VCNL4010_CMD_REG, 0 },
    { "VERSION",                VCNL4010_PROD_ID_VER, 0 },
    { "VCNL4010_PROX_RATE",            VCNL4010_PROX_RATE, 0 },
    { "IR_LED_CURR",            VCNL4010_IR_LED_CURR, 0 },
    { "AMB_LIGHT_PARAM",            VCNL4010_AMB_LIGHT_PARAM, 0 },
    { "MSB_AMB_LIGHT_RESULT",        VCNL4010_MSB_AMB_LIGHT_RESULT, 0 }=
,
    { "LSB_AMB_LIGHT_RESULT",        VCNL4010_LSB_AMB_LIGHT_RESULT, 0 }=
,
    { "MSB_PROX_MEASURE_RESULT",        VCNL4010_MSB_PROX_MEASURE_RESUL=
T, 0 },
    { "LSB_PROX_MEASURE_RESULT",        VCNL4010_LSB_PROX_MEASURE_RESUL=
T, 0 },
    { "VCNL4010_INTERRUPT_CTRL",        VCNL4010_INTERRUPT_CTRL, 0 },
    { "VCNL4010_MSB_LOW_THRESHOLD",        VCNL4010_MSB_LOW_THRESHOLD, =
0 },
    { "VCNL4010_LSB_LOW_THRESHOLD",        VCNL4010_LSB_LOW_THRESHOLD, =
0 },
    { "VCNL4010_MSB_HIGH_THRESHOLD",    VCNL4010_MSB_HIGH_THRESHOLD, 0 =
},
    { "VCNL4010_LSB_HIGH_THRESHOLD",    VCNL4010_LSB_HIGH_THRESHOLD, 0 =
},
    { "VCNL4010_INTERRUPT_STATUS",        VCNL4010_INTERRUPT_STATUS, 0 =
},
    { "VCNL4010_PROX_MODU_TIMING_ADJ",    VCNL4010_PROX_MODU_TIMING_ADJ=
, 0 },
};
#endif

static int vcnl4010_write(struct vcnl4010_data *data, u8 reg, u8 val)
{
    int ret =3D 0;

    ret =3D i2c_smbus_write_byte_data(data->client, reg, val);
    if (ret < 0)
        dev_err(&data->client->dev,
            "i2c_smbus_write_byte_data failed\n");
    return ret;
}

static int vcnl4010_read_transfer(struct vcnl4010_data *data,
        unsigned short data_addr, char *data_buf, int count)
{
    int ret;
    int counter =3D 5;
    char *data_buffer =3D data_buf;

    struct i2c_msg msgs[] =3D {
        {
        .addr =3D data->client->addr,
        .flags =3D data->client->flags,
        .len =3D 1,
        .buf =3D data_buffer,
        },
        {
        .addr =3D data->client->addr,
        .flags =3D (data->client->flags) | I2C_M_RD,
        .len =3D count,
        .buf =3D data_buffer,
        },
    };

    data_buffer[0] =3D data_addr;
    msgs->buf =3D data_buffer;

    do {
        ret =3D i2c_transfer(data->client->adapter, msgs, 2);
        if (ret !=3D 2)
        {
            dev_err(&data->client->dev,
                "i2c_transfer failed\n");
            counter--;
            msleep(1);
        }
        else
        {
            return 0;
        }
    } while (counter >=3D 0);

    return -1;
}

static void vcnl4010_enter_self_timed_mode(struct vcnl4010_data *data)
{
    int ret =3D 0;

    pr_info("vcnl4010: Enter self refresh mode");

    mutex_lock(&data->lock);
    ret =3D ret || vcnl4010_write(data, VCNL4010_CMD_REG,              =
0x00);
    ret =3D ret || vcnl4010_write(data, VCNL4010_IR_LED_CURR,          =
  20);
    ret =3D ret || vcnl4010_write(data, VCNL4010_INTERRUPT_CTRL,       =
0x62);
    ret =3D ret || vcnl4010_write(data, VCNL4010_PROX_MODU_TIMING_ADJ, =
0x01);
    ret =3D ret || vcnl4010_write(data, VCNL4010_PROX_RATE,            =
0x04);
    ret =3D ret || vcnl4010_write(data, VCNL4010_CMD_REG,              =
0x03);
    mutex_unlock(&data->lock);

    if(ret !=3D 0)
        pr_err("vcnl4010: Failed to enter self refresh mode");
}

static uint32_t vcnl4010_poll_prox_value(struct vcnl4010_data *data)
{
    uint8_t reg_val, timeout;
    uint32_t data_val =3D 0;

    //device refreshs itself 31 times per secs, if value not ready, wai=
t a little bit and try again
    for(timeout =3D 0; timeout < 10; timeout++)
    {
        mutex_lock(&data->lock);
        vcnl4010_read_transfer(data, VCNL4010_CMD_REG, &reg_val, 1);
        if(reg_val & 0x20)
        {
            vcnl4010_read_transfer(data, VCNL4010_MSB_PROX_MEASURE_RESU=
LT, &reg_val, 1);
            data_val =3D reg_val << 8;

            vcnl4010_read_transfer(data, VCNL4010_LSB_PROX_MEASURE_RESU=
LT, &reg_val, 1);
            data_val |=3D reg_val;
            mutex_unlock(&data->lock);
            break;
        }
        mutex_unlock(&data->lock);
        msleep_interruptible(8);
    }

    if(timeout =3D=3D 10)
        pr_err("vcnl4010: get prox value failed");

    return data_val;
}

static vcnl4010InterruptState vcnl4010_poll_interrupt_value(struct vcnl=
4010_data *data)
{
    vcnl4010InterruptState retVal =3D eNone;
    uint8_t reg_val =3D 0;

    mutex_lock(&data->lock);
    if(vcnl4010_read_transfer(data, VCNL4010_INTERRUPT_STATUS, &reg_val=
, 1) =3D=3D 0)
    {
        if(reg_val & VCNL4010_INT_THRES_HI)
            retVal =3D eNear;
        if(reg_val & VCNL4010_INT_THRES_LOW)
            retVal =3D eFar;

        if((reg_val & (VCNL4010_INT_THRES_HI | VCNL4010_INT_THRES_LOW))=
 !=3D 0)
        {
            vcnl4010_write(data, VCNL4010_INTERRUPT_STATUS, VCNL4010_IN=
T_THRES_HI || VCNL4010_INT_THRES_LOW);
        }
    }

    mutex_unlock(&data->lock);
    return retVal;
}

static void vcnl4010_set_int_threshold(struct vcnl4010_data *data, vcnl=
4010InterruptState type)
{
    uint16_t threshold_hi;
    uint16_t threshold_low;

    if(type =3D=3D eNear)
    {
        threshold_hi =3D data->prox_offset + data->threshold_hi;
        threshold_low =3D 0;
    }
    else
    {
        threshold_hi =3D 0xffff;
        threshold_low =3D data->prox_offset + data->threshold_low;
    }

    mutex_lock(&data->lock);
    vcnl4010_write(data, VCNL4010_LSB_LOW_THRESHOLD, threshold_low & 0x=
ff);
    vcnl4010_write(data, VCNL4010_MSB_LOW_THRESHOLD, (threshold_low >> =
8) & 0xff);
    vcnl4010_write(data, VCNL4010_LSB_HIGH_THRESHOLD, threshold_hi & 0x=
ff);
    vcnl4010_write(data, VCNL4010_MSB_HIGH_THRESHOLD, (threshold_hi >> =
8) & 0xff);
    mutex_unlock(&data->lock);
}

static int proximity_thread(void *data)
{
    struct vcnl4010_data *prox_data =3D data;

    while (!kthread_should_stop())
    {
        vcnl4010InterruptState lState =3D vcnl4010_poll_interrupt_value=
(prox_data);
        if(lState !=3D eNone && lState !=3D prox_data->last_interrupt_s=
tate)
        {
            prox_data->last_interrupt_state =3D lState;
            if(lState =3D=3D eFar)
            {
                input_report_abs (prox_data->input_dev, ABS_DISTANCE, V=
CNL4010_FAR_DISTANCE);
                input_sync(prox_data->input_dev);
                vcnl4010_set_int_threshold(prox_data, eNear);
            }
            else
            {
                input_report_abs (prox_data->input_dev, ABS_DISTANCE, 0=
);
                input_sync(prox_data->input_dev);
                vcnl4010_set_int_threshold(prox_data, eFar);
            }
        }
        msleep_interruptible (prox_data->self_refresh_poll_rate); //250=
ms
    }
    return 0;
}

static ssize_t vcnl4010_get_raw_prox(struct device *dev, struct device_=
attribute *attr, char *buf)
{
    uint32_t data_val;
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);

    data_val =3D vcnl4010_poll_prox_value(data);

    return sprintf(buf, "%d\n", data_val);
}

static ssize_t vcnl4010_get_offset(struct device *dev,
                  struct device_attribute *attr, char *buf)
{
    unsigned n;
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    n =3D scnprintf(buf, PAGE_SIZE, "%d", data->prox_offset);

    return n;
}

static ssize_t vcnl4010_set_offset(struct device *dev,
                   struct device_attribute *attr,
                   const char *buf, size_t count)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);

    int value;
    if (sscanf(buf, "%d", &value) !=3D 1) {
        pr_err("%s:unable to parse input\n", __func__);
        return -1;
    }
    if(value > 0xffff || value < 0)
    {
        pr_err("%s:invalid offset value\n", __func__);
        return -1;
    }

    data->prox_offset =3D value;

    if(data->last_interrupt_state =3D=3D eFar)
        vcnl4010_set_int_threshold(data, eNear);
    else
        vcnl4010_set_int_threshold(data, eFar);

    return count;
}

static ssize_t vcnl4010_get_threshold_hi(struct device *dev,
                  struct device_attribute *attr, char *buf)
{
    unsigned n;
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    n =3D scnprintf(buf, PAGE_SIZE, "%d", data->threshold_hi);

    return n;
}

static ssize_t vcnl4010_set_threshold_hi(struct device *dev,
                   struct device_attribute *attr,
                   const char *buf, size_t count)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);

    int value;
    if (sscanf(buf, "%d", &value) !=3D 1) {
        pr_err("%s:unable to parse input\n", __func__);
        return -1;
    }
    if(value > 0xffff || value < 0)
    {
        pr_err("%s:invalid threshold value\n", __func__);
        return -1;
    }

    data->threshold_hi =3D value;

    if(data->last_interrupt_state =3D=3D eFar)
        vcnl4010_set_int_threshold(data, eNear);
    else
        vcnl4010_set_int_threshold(data, eFar);

    return count;
}

static ssize_t vcnl4010_get_threshold_low(struct device *dev,
                  struct device_attribute *attr, char *buf)
{
    unsigned n;
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    n =3D scnprintf(buf, PAGE_SIZE, "%d", data->threshold_low);

    return n;
}

static ssize_t vcnl4010_set_threshold_low(struct device *dev,
                   struct device_attribute *attr,
                   const char *buf, size_t count)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);

    int value;
    if (sscanf(buf, "%d", &value) !=3D 1) {
        pr_err("%s:unable to parse input\n", __func__);
        return -1;
    }
    if(value > 0xffff || value < 0)
    {
        pr_err("%s:invalid threshold value\n", __func__);
        return -1;
    }

    data->threshold_low =3D value;

    if(data->last_interrupt_state =3D=3D eFar)
        vcnl4010_set_int_threshold(data, eNear);
    else
        vcnl4010_set_int_threshold(data, eFar);

    return count;
}

#ifdef VCNL4010_DEBUG
static ssize_t vcnl4010_registers_show(struct device *dev,
                  struct device_attribute *attr, char *buf)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    unsigned i, n, reg_count;
    uint8_t value;

    mutex_lock(&data->lock);
    reg_count =3D sizeof(vcnl4010_regs) / sizeof(vcnl4010_regs[0]);
    for (i =3D 0, n =3D 0; i < reg_count; i++)
    {
        vcnl4010_read_transfer(data, vcnl4010_regs[i].reg, &value, 1);
        n +=3D scnprintf(buf + n, PAGE_SIZE - n, "%-20s =3D 0x%02X\n",
                   vcnl4010_regs[i].name,
                   value);
    }
    mutex_unlock(&data->lock);

    return n;
}

static ssize_t vcnl4010_registers_store(struct device *dev,
                   struct device_attribute *attr,
                   const char *buf, size_t count)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    unsigned i, reg_count, value;
    int error =3D 0;
    char name[30];

    if (count >=3D 30) {
        pr_err("%s:input too long\n", __func__);
        return -1;
    }

    if (sscanf(buf, "%s %x", name, &value) !=3D 2) {
        pr_err("%s:unable to parse input\n", __func__);
        return -1;
    }

    mutex_lock(&data->lock);
    reg_count =3D sizeof(vcnl4010_regs) / sizeof(vcnl4010_regs[0]);
    for (i =3D 0; i < reg_count; i++) {
        if (!strcmp(name, vcnl4010_regs[i].name)) {
            if (vcnl4010_regs[i].writeable) {
                error =3D vcnl4010_write(data,
                    vcnl4010_regs[i].reg,
                    value);
                if (error) {
                    pr_err("%s:Failed to write %s\n",
                        __func__, name);
                    mutex_unlock(&data->lock);
                    return -1;
                }
            } else {
                pr_err("%s:Register %s is not writeable\n",
                        __func__, name);
                mutex_unlock(&data->lock);
                return -1;
            }
            mutex_unlock(&data->lock);
            return count;
        }
    }
    mutex_unlock(&data->lock);

    pr_err("%s:no such register %s\n", __func__, name);
    return -1;
}

static DEVICE_ATTR(registers, S_IWUSR | S_IRUGO,
        vcnl4010_registers_show, vcnl4010_registers_store);
#endif


//only root
//#define FILE_PERMS S_IWUSR | S_IRUGO
//all users
#define FILE_PERMS S_IWUGO | S_IRUGO

static DEVICE_ATTR(prox_value, FILE_PERMS, vcnl4010_get_raw_prox, NULL)=
;
static DEVICE_ATTR(prox_offset, FILE_PERMS, vcnl4010_get_offset, vcnl40=
10_set_offset);
static DEVICE_ATTR(threshold_low, FILE_PERMS, vcnl4010_get_threshold_lo=
w, vcnl4010_set_threshold_low);
static DEVICE_ATTR(threshold_hi, FILE_PERMS, vcnl4010_get_threshold_hi,=
 vcnl4010_set_threshold_hi);

static struct attribute *vcnl4010_attrs[] =3D
{
    &dev_attr_prox_value.attr,
    &dev_attr_prox_offset.attr,
    &dev_attr_threshold_low.attr,
    &dev_attr_threshold_hi.attr,
#ifdef VCNL4010_DEBUG
    &dev_attr_registers.attr,
#endif
    NULL
};

static const struct attribute_group vcnl4010_attr_group =3D {
    .attrs =3D vcnl4010_attrs,
};

static int __devinit vcnl4010_driver_probe(struct i2c_client *client, c=
onst struct i2c_device_id *id)
{
    struct vcnl4010_platform_data *pdata =3D client->dev.platform_data;
    struct vcnl4010_data *data;
    int ret =3D 0;
    uint8_t reg_val =3D 0;

    pr_info("%s: Enter\n", __func__);

    if (pdata =3D=3D NULL) {
        pr_err("%s: Platform data not found\n", __func__);
        return -ENODEV;
    }

    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
        pr_err("%s: need I2C_FUNC_I2C\n", __func__);
        return -ENODEV;
    }

    /* alloc memory for data structure */
    data =3D kzalloc(sizeof(struct vcnl4010_data), GFP_KERNEL);
    if (!data) {
        ret =3D -ENOMEM;
        goto error;
    }

    mutex_init(&data->lock);

    data->input_dev =3D input_allocate_device();

    if (!data->input_dev)
    {
        ret =3D -ENOMEM;
        printk("%s: input device allocate failed: %d\n", __func__, ret)=
;
        goto dev_allocate_error;
    }

    data->input_dev->name =3D "proximity";
    set_bit(EV_ABS, data->input_dev->evbit);
    set_bit(ABS_DISTANCE, data->input_dev->absbit);
    data->input_dev->phys =3D "proximity/input";

    input_set_abs_params( data->input_dev, ABS_DISTANCE, 0, VCNL4010_FA=
R_DISTANCE, 0, 0 );

    ret =3D input_register_device(data->input_dev);
    if (ret) {
        printk("%s: input device register failed:%d\n", __func__, ret);
        goto dev_register_error;
    }

    data->pdata =3D pdata;
    data->client =3D client;
    data->self_refresh_poll_rate =3D pdata->def_poll_rate;
    data->last_interrupt_state =3D eFar;  //Start as far
    data->prox_offset =3D 17000;  //todo set correct default value
    data->threshold_low =3D 105;
    data->threshold_hi =3D  110;

    i2c_set_clientdata(client, data);

    //test for device presence
    if(vcnl4010_read_transfer(data, VCNL4010_PROD_ID_VER, &reg_val, 1) =
!=3D0 )
    {
        pr_err("vcnl4010: Device not found!");
        goto nochip;
    }

    if(reg_val !=3D 0x21)
    {
        pr_err("vcnl4010: Found device isn't a vcnl4010, is a vcnl4000 =
installed?");
        goto badchip;
    }

    pr_info("vcnl4010: Found device!");

    vcnl4010_set_int_threshold(data, eNear);  //Generate an interrupt w=
hen become near
    vcnl4010_enter_self_timed_mode(data);

    input_report_abs (data->input_dev, ABS_DISTANCE, VCNL4010_FAR_DISTA=
NCE);
    input_sync(data->input_dev);

    ret =3D sysfs_create_group(&client->dev.kobj, &vcnl4010_attr_group)=
;
    if (ret)
        goto sysfs_error;

    /* start the kthread */
    proximity_intr =3D kthread_run(proximity_thread, data, "proximity_t=
hread");

    return 0;

sysfs_error:
badchip:
nochip:
    input_unregister_device(data->input_dev);
dev_register_error:
    input_free_device(data->input_dev);
dev_allocate_error:
    mutex_destroy(&data->lock);
    kfree(data);
error:
    return ret;
}

static int __devexit vcnl4010_driver_remove(struct i2c_client *client)
{
    struct vcnl4010_data *data =3D i2c_get_clientdata(client);
    int ret =3D 0;

    sysfs_remove_group(&client->dev.kobj, &vcnl4010_attr_group);

    i2c_set_clientdata(client, NULL);

    input_free_device(data->input_dev);
    mutex_destroy(&data->lock);
    kfree(data);

    return ret;
}


#ifdef CONFIG_PM
static int vcnl4010_driver_suspend(struct device *dev)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    mutex_lock(&data->lock);
    vcnl4010_write(data, VCNL4010_CMD_REG,              0x00);
    vcnl4010_write(data, VCNL4010_IR_LED_CURR,             0);
    mutex_unlock(&data->lock);

    return 0;
}

static int vcnl4010_driver_resume(struct device *dev)
{
    struct platform_device *pdev =3D to_platform_device(dev);
    struct vcnl4010_data *data =3D platform_get_drvdata(pdev);
    vcnl4010_enter_self_timed_mode(data);
    if(data->last_interrupt_state =3D=3D eFar)
        vcnl4010_set_int_threshold(data, eNear);
    else
        vcnl4010_set_int_threshold(data, eFar);

    return 0;
}

static const struct dev_pm_ops vcnl4010_pm_ops =3D {
    .suspend =3D vcnl4010_driver_suspend,
    .resume =3D vcnl4010_driver_resume,
};
#endif

static const struct i2c_device_id vcnl4010_idtable[] =3D {
    { DRIVER_NAME, 0 },
    { },
};

MODULE_DEVICE_TABLE(i2c, vcnl4010_idtable);

static struct i2c_driver vcnl4010_driver =3D {
    .probe        =3D vcnl4010_driver_probe,
    .remove        =3D vcnl4010_driver_remove,
    .id_table    =3D vcnl4010_idtable,
    .driver =3D {
        .name =3D DRIVER_NAME,
#ifdef CONFIG_PM
        .pm =3D &vcnl4010_pm_ops,
#endif
    },
};

static int __init vcnl4010_driver_init(void)
{
    return i2c_add_driver(&vcnl4010_driver);
}

static void __exit vcnl4010_driver_exit(void)
{
    i2c_del_driver(&vcnl4010_driver);
}

module_init(vcnl4010_driver_init);
module_exit(vcnl4010_driver_exit);

MODULE_DESCRIPTION("VCNL4010 Proximity Driver");
MODULE_LICENSE("GPL");
