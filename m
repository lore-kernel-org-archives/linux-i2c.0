From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 3/3] gpio: add support for Cypress CYUSBS234 USB-GPIO
 adapter
Date: Sun, 14 Dec 2014 07:43:55 +0530
Message-ID: <548CF263.4000107@gmail.com>
References: <1418471264-31896-1-git-send-email-muth@cypress.com> <1418471264-31896-3-git-send-email-muth@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418471264-31896-3-git-send-email-muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 13 December 2014 05:17 PM, Muthu Mani wrote:

> Adds support for USB-GPIO interface of Cypress Semiconductor
> CYUSBS234 USB-Serial Bridge controller.
>
> The GPIO get/set can be done through vendor command on control endpoint
> for the configured gpios.
>
> Details about the device can be found at:
> http://www.cypress.com/?rID=84126
>
> Signed-off-by: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>

(...)

> +static int cy_gpio_get(struct gpio_chip *chip,
> +                       unsigned offset)
> +{
> +       int ret;
> +       char *buf;
> +       u16 wIndex, wValue;
> +       struct cyusbs_gpio *gpio = to_cyusbs_gpio(chip);
> +       struct cyusbs23x *cyusbs = gpio->cyusbs;
> +
> +       if (gpio->out_gpio & BIT(offset))
> +               return !!(gpio->out_value & BIT(offset));
> +
> +       wValue = offset;
> +       wIndex = 0;
> +       buf = kmalloc(CY_GPIO_GET_LEN, GFP_KERNEL);
> +       if (buf == NULL)
> +               return -ENOMEM;
> +

Using '!' operator is preferred!
if(!buf)
	return -ENOMEM;

> +       ret = usb_control_msg(cyusbs->usb_dev,
> +                       usb_rcvctrlpipe(cyusbs->usb_dev, 0),
> +                       CY_GPIO_GET_VALUE_CMD,
> +                       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> +                       wValue, wIndex, buf, CY_GPIO_GET_LEN,
> +                       CY_USBS_CTRL_XFER_TIMEOUT);
> +       if (ret == CY_GPIO_GET_LEN) {
> +               dev_dbg(chip->dev, "%s: offset=%d %02X %02X\n",
> +                       __func__, offset, buf[0], buf[1]);
> +               if (buf[0] == 0)
> +                       ret = !!buf[1];
> +               else
> +                       ret = -EIO;
> +       } else {
> +               dev_err(chip->dev, "%s: offset=%d %d\n", __func__, offset, ret);
> +               ret = -EIO;
> +       }
> +
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static void cy_gpio_set(struct gpio_chip *chip,
> +                       unsigned offset, int value)
> +{
> +       int ret;
> +       u16 wIndex, wValue;
> +       struct cyusbs_gpio *gpio = to_cyusbs_gpio(chip);
> +       struct cyusbs23x *cyusbs = gpio->cyusbs;
> +
> +       wValue = offset;
> +       wIndex = value;
> +
> +       ret = usb_control_msg(cyusbs->usb_dev,
> +                       usb_sndctrlpipe(cyusbs->usb_dev, 0),
> +                       CY_GPIO_SET_VALUE_CMD,
> +                       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> +                       wValue, wIndex, NULL, 0, CY_USBS_CTRL_XFER_TIMEOUT);
> +       if (ret < 0)
> +               dev_err(chip->dev, "error setting gpio %d: %d\n", offset, ret);
> +       else {
> +               if (value)
> +                       gpio->out_value |= BIT(offset);
> +               else
> +                       gpio->out_value &= ~BIT(offset);
> +       }
> +}
> +

Following Two functions returning an error code. Generally when control reached
to end of the function indicates that the function call is success.

Returning an error is not best way. On success every function will return a success return code..

> +static int cy_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       u32 gpios;
> +       struct cyusbs_gpio *gpio = to_cyusbs_gpio(chip);
> +
> +       gpios = gpio->out_gpio | gpio->in_gpio;
> +       if (gpios & BIT(offset))
> +               return 0;
> +
> +       return -ENODEV;
> +}
> +
> +static int cy_gpio_get_direction(struct gpio_chip *chip,
> +                                       unsigned offset)
> +{
> +       struct cyusbs_gpio *gpio = to_cyusbs_gpio(chip);
> +
> +       if (gpio->out_gpio & BIT(offset))
> +               return GPIOF_DIR_OUT;
> +       else if (gpio->in_gpio & BIT(offset))
> +               return GPIOF_DIR_IN;
> +
> +       return -EIO;
> +}
> +
> +static int cy_get_device_config(struct cyusbs23x *cyusbs, u8 *buf)
> +{
> +       int ret;
> +
> +       ret = usb_control_msg(cyusbs->usb_dev,
> +                       usb_sndctrlpipe(cyusbs->usb_dev, 0),
> +                       CY_DEV_ENABLE_CONFIG_READ_CMD,
> +                       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
> +                       CY_USBS_READ_CONFIG, CY_USBS_ENABLE_READ, NULL, 0,
> +                       CY_USBS_CTRL_XFER_TIMEOUT);
> +       if (ret) {
> +               dev_err(&cyusbs->usb_dev->dev,
> +                       "%s: enable config read status %d\n", __func__, ret);
> +               return -ENODEV;
> +       }
> +
> +       ret = usb_control_msg(cyusbs->usb_dev,
> +                       usb_rcvctrlpipe(cyusbs->usb_dev, 0),
> +                       CY_DEV_READ_CONFIG_CMD,
> +                       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> +                       0, 0, buf, CY_DEVICE_CONFIG_SIZE,
> +                       CY_USBS_CTRL_XFER_TIMEOUT);
> +       if (ret != CY_DEVICE_CONFIG_SIZE) {
> +               dev_err(&cyusbs->usb_dev->dev,
> +                       "%s: read config status %d\n", __func__, ret);
> +               return -ENODEV;
> +       }
> +
> +       ret = usb_control_msg(cyusbs->usb_dev,
> +                       usb_sndctrlpipe(cyusbs->usb_dev, 0),
> +                       CY_DEV_ENABLE_CONFIG_READ_CMD,
> +                       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
> +                       CY_USBS_READ_CONFIG, CY_USBS_DISABLE_READ, NULL, 0,
> +                       CY_USBS_CTRL_XFER_TIMEOUT);
> +       if (ret) {
> +               dev_err(&cyusbs->usb_dev->dev,
> +                       "%s: disable config read status %d\n", __func__, ret);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cy_gpio_retrieve_gpio_details(struct cyusbs_gpio *gpio)
> +{
> +       int ret;
> +       u32 drive0, drive1;
> +       u8 *buf;
> +       struct cyusbs23x *cyusbs = gpio->cyusbs;
> +
> +       buf = kzalloc(CY_DEVICE_CONFIG_SIZE, GFP_KERNEL);
> +       if (buf == NULL)
> +               return -ENOMEM;
> +

Using '!' operator is preferred!
if(!buf)
	return -ENOMEM;

> +       ret = cy_get_device_config(cyusbs, buf);
> +       if (ret) {
> +               dev_err(&cyusbs->usb_dev->dev,
> +                       "could not retrieve device configuration\n");
> +               goto error;
> +       }
> +
> +       /* Retrieve the GPIO configuration details */
> +       drive0 = le32_to_cpu(*((u32 *)&buf[CY_CFG_DRIVE0_GPIO_OFFSET]));
> +       drive1 = le32_to_cpu(*((u32 *)&buf[CY_CFG_DRIVE1_GPIO_OFFSET]));
> +       gpio->out_gpio = drive0 | drive1;
> +       gpio->out_value = drive1;
> +       gpio->in_gpio = le32_to_cpu(*((u32 *)&buf[CY_CFG_INPUT_GPIO_OFFSET]));
> +
> +error:
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static int cyusbs23x_gpio_probe(struct platform_device *pdev)
> +{
> +       struct cyusbs23x *cyusbs;
> +       struct cyusbs_gpio *cy_gpio;
> +       int ret = 0;
> +
> +       dev_dbg(&pdev->dev, "%s\n", __func__);
> +
> +       cyusbs = dev_get_drvdata(pdev->dev.parent);
> +
> +       cy_gpio = devm_kzalloc(&pdev->dev, sizeof(*cy_gpio), GFP_KERNEL);
> +       if (cy_gpio == NULL)
> +               return -ENOMEM;
> +

Using '!' operator is preferred!
if(!cy_gpio)
	return -ENOMEM;

> +       cy_gpio->cyusbs = cyusbs;
> +       /* retrieve GPIO configuration info */
> +       ret = cy_gpio_retrieve_gpio_details(cy_gpio);
> +       if (ret) {
> +               dev_err(&pdev->dev, "could not retrieve gpio details\n");
> +               return -ENODEV;
> +       }
> +
> +       /* registering gpio */
> +       cy_gpio->gpio.label = dev_name(&pdev->dev);
> +       cy_gpio->gpio.dev = &pdev->dev;
> +       cy_gpio->gpio.owner = THIS_MODULE;
> +       cy_gpio->gpio.base = -1;
> +       cy_gpio->gpio.ngpio = CYUSBS234_GPIO_NUM;
> +       cy_gpio->gpio.can_sleep = true;
> +       cy_gpio->gpio.request = cy_gpio_request;
> +       cy_gpio->gpio.set = cy_gpio_set;
> +       cy_gpio->gpio.get = cy_gpio_get;
> +       cy_gpio->gpio.get_direction = cy_gpio_get_direction;

One line space...

-- 
Thanks and Regards,
Varka Bhadram.
