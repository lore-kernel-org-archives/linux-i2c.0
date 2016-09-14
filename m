From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v5] i2c: mux: mellanox: add driver
Date: Wed, 14 Sep 2016 10:42:55 +0200
Message-ID: <df9f3e60-a4e1-9663-6ea1-2671cca63956@axentia.se>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
 <eb927385-4598-2fd0-8200-7d6c4945569f@axentia.se>
 <AM5PR0501MB209778ABF3397CD457AA1A69A2F10@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM5PR0501MB209778ABF3397CD457AA1A69A2F10@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

Wolfram, please pick up v5 for i2c-next whenever timing is right so that
it gets more testing etc. I didn't do any recent compile-testing myself,
but if you think that is required on the final version I can of course
spend some time on it. (But isn't that what all the infrastructure is
there to help with?)   Thanks!

On 2016-09-14 10:10, Vadim Pasternak wrote:
> Peter Rosin wrote:
>> On 2016-09-13 22:37, vadimp@mellanox.com wrote:
>>> From: Vadim Pasternak <vadimp@mellanox.com>
>>>
>>> This driver allows I2C routing controlled through CPLD select
>>> registers on a wide range of Mellanox systems (CPLD Lattice device).
>>> MUX selection is provided by digital and analog HW. Analog part is not
>>> under SW control.
>>> Digital part is under CPLD control (channel selection/de-selection).
>>
>> *snip*
>>
>>> +/* Platform data for the CPLD I2C multiplexers */
>>> +
>>> +/* mlxcpld_mux_plat_data - per mux data, used with
>>> +i2c_register_board_info
>>> + * @adap_ids - adapter array
>>> + * @num_adaps - number of adapters
>>> + * @sel_reg_addr - mux select register offset in CPLD space  */
>>> +struct mlxcpld_mux_plat_data {
>>> +	int *adap_ids;
>>> +	int num_adaps;
>>> +	int sel_reg_addr;
>>> +};
>>> +
>>> +#endif /* _LINUX_I2C_MLXCPLD_H */
>>>
>>
>> Hmm, you never confirmed that you need to support different register values in
>> the CPLD with sel_reg_addr. I can see that there is a possibility that you actually
>> really need it, but I'd like to remove that variable if at all possible.
> 
> Yes, it could be different register values.
> Actually CPLD can also be programmed in different way.
> So, I really need it.

Oh well :-)

Cheers,
Peter

>>
>> If you can confirm that you need that, this is
>>
>> Acked-by: Peter Rosin <peda@axentia.se>
