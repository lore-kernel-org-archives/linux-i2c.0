From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v10 3/7] i2c: fsi: Add port structures
Date: Wed, 20 Jun 2018 13:29:04 +0930
Message-ID: <CACPK8XdQvRcS+n33BT=Fwm4OoMfck5B3NX=QKJc0HgoqMjwXTg@mail.gmail.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-4-git-send-email-eajames@linux.vnet.ibm.com> <5d1f980286e2bba566421ebb29721770303fcf09.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d1f980286e2bba566421ebb29721770303fcf09.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

On 20 June 2018 at 13:04, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-06-13 at 14:36 -0500, Eddie James wrote:
>>  }
>>
>> +static int fsi_i2c_remove(struct device *dev)
>> +{
>> +       struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
>> +       struct fsi_i2c_port *port;
>> +
>> +       list_for_each_entry(port, &i2c->ports, list) {
>> +               i2c_del_adapter(&port->adapter);
>> +               kfree(port);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
> This is a use-after-free, the list linkage of the freed port is used to
> get to the next one. With memory poisoning, kbooom !
>
> You can fold that in:
>
> From f9d9092160897e7308f6990067a03e937339537f Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 20 Jun 2018 13:27:32 +1000
> Subject: [PATCH] i2c: fsi: Fix use after free

This fixes the issue I was seeing. For the series:

Tested-by: Joel Stanley <joel@jms.id.au>

Thanks,

Joel


>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index 713959b44403..ff69ab6aa79a 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -696,9 +696,10 @@ static int fsi_i2c_probe(struct device *dev)
>  static int fsi_i2c_remove(struct device *dev)
>  {
>         struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
> -       struct fsi_i2c_port *port;
> +       struct fsi_i2c_port *port, *tmp;
>
> -       list_for_each_entry(port, &i2c->ports, list) {
> +       list_for_each_entry_safe(port,tmp, &i2c->ports, list) {
> +               list_del(&port->list);
>                 i2c_del_adapter(&port->adapter);
>                 kfree(port);
>         }
>
