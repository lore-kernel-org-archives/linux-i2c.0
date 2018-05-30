From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
Date: Wed, 30 May 2018 10:47:15 -0500
Message-ID: <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org



On 05/29/2018 06:19 PM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> Add and initialize I2C adapters for each port on the FSI-attached I2C
>> master. Ports for each master are defined in the devicetree.
>> +#include <linux/of.h>
>
>> +static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>> +{
>> +       int rc;
>> +       struct fsi_device *fsi = port->master->fsi;
>> +       u32 mode, dummy = 0;
>> +       u16 old_port;
>> +
>> +       rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
>> +       if (rc)
>> +               return rc;
>> +
>> +       old_port = GETFIELD(I2C_MODE_PORT, mode);
>> +
>> +       if (old_port != port->port) {
> Why not simple
>
> if (port->port == GETFIELD())
>    return 0;
>
> ?

Sure.

>
>> +               /* reset engine when port is changed */
>> +               rc = fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>> +               if (rc)
>> +                       return rc;
>> +       }
>> +       return rc;
> It's hardly would be non-zero, right?

No, fsi_i2c_read_reg and fsi_i2c_write_reg both return 0 on success and 
non-zero on error. That is the desired behavior of this function also.

>
>> +}
>>   static int fsi_i2c_probe(struct device *dev)
>>   {
> Isn't below somehow repeats of_i2c_register_devices() ?
> Why not to use it?

Because I need to assign all these port structure fields. Also looks 
like of_i2c_register_devices creates new devices; I just want an adapter 
for each port.

>
>> +       /* Add adapter for each i2c port of the master. */
>> +       for_each_available_child_of_node(dev->of_node, np) {
>> +               rc = of_property_read_u32(np, "reg", &port_no);
>> +               if (rc || port_no > USHRT_MAX)
>> +                       continue;
>> +
>> +               port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> +               if (!port)
>> +                       break;
>> +
>> +               port->master = i2c;
>> +               port->port = port_no;
>> +
>> +               port->adapter.owner = THIS_MODULE;
>> +               port->adapter.dev.of_node = np;
>> +               port->adapter.dev.parent = dev;
>> +               port->adapter.algo = &fsi_i2c_algorithm;
>> +               port->adapter.algo_data = port;
>> +
>> +               snprintf(port->adapter.name, sizeof(port->adapter.name),
>> +                        "i2c_bus-%u", port_no);
>> +
>> +               rc = i2c_add_adapter(&port->adapter);
>> +               if (rc < 0) {
>> +                       dev_err(dev, "Failed to register adapter: %d\n", rc);
>> +                       devm_kfree(dev, port);
> This hurts my eyes. Why?!

What would you suggest instead?

>
>> +                       continue;
>> +               }
>> +
>> +               list_add(&port->list, &i2c->ports);
>> +       }
>> +
>>          dev_set_drvdata(dev, i2c);
>>
>>          return 0;
>>   }
>> +       if (!list_empty(&i2c->ports)) {
> My gosh, this is done already in list_for_each*()

No, list_for_each_entry does NOT check if the list is empty or if the 
first entry is NULL.

Thanks,
Eddie

>
>> +               list_for_each_entry(port, &i2c->ports, list) {
>> +                       i2c_del_adapter(&port->adapter);
>> +               }
>> +       }
>
>
