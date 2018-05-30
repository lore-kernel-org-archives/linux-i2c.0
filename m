From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 5/7] drivers/i2c: Add transfer implementation for FSI
 algorithm
Date: Wed, 30 May 2018 15:53:53 -0500
Message-ID: <710a9afe-e268-9dbc-5183-9793d4eae2d3@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-6-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vch1uEVvXadVR68tsDY-51=U+7FGr=5k0N5QtpcXpE_3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vch1uEVvXadVR68tsDY-51=U+7FGr=5k0N5QtpcXpE_3A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org



On 05/29/2018 07:08 PM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> Execute I2C transfers from the FSI-attached I2C master. Use polling
>> instead of interrupts as we have no hardware IRQ over FSI.
>> +       if (msg->flags & I2C_M_RD)
>> +               cmd |= I2C_CMD_READ;
> I think we have a helper for this, though not sure.

Didn't see any other I2C drivers using any helper for msg->flags.

>
>> +static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +                             u8 fifo_count)
>> +{
>> +       int write;
>> +       int rc = 0;
> Redundant assignment.
>
>> +       struct fsi_i2c_master *i2c = port->master;
>> +       int bytes_to_write = i2c->fifo_size - fifo_count;
>> +       int bytes_remaining = msg->len - port->xfrd;
>> +       if (bytes_to_write > bytes_remaining)
>> +               bytes_to_write = bytes_remaining;
> _write = min(_write, _remaining);
>
>> +       while (bytes_to_write > 0) {
>> +               write = bytes_to_write;
>> +               /* fsi limited to max 4 byte aligned ops */
>> +               if (bytes_to_write > 4)
>> +                       write = 4;
>> +               else if (write == 3)
>> +                       write = 2;
> write = min_t(int, 4, rounddown_pow_of_two(bytes_to_write));
>
> Also check it carefully, it might be optimized even more, though I
> didn't think much.

I think it is more readable this way, and I'm not convinced the 
min(rounddown()) is faster. I did however add a common function to do 
this check since it's performed in both the read and write fifo 
functions. Let me know what you think on v8.

Thanks,
Eddie
