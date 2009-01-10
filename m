From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Subject: Regulator consumer and i2c device interaction.
Date: Sat, 10 Jan 2009 16:01:22 +0000
Message-ID: <4968C652.2050300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754392AbZAJQBc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear All,

Currently regulator consumers are registered and identified via a pointer to the relevant
device:

e.g. via a regulator consumer supply structure:
static struct regulator_consumer_supply imote2_sensor_3_con[] = {
	{
		.dev = &sht15.dev,
		.supply = "vcc",
	},
};

static struct regulator_init_data imote2_ldo_init_data[] = {{
	{
	 	.constraints = {
		.name = "vcc_sensor_3",
		.min_uV = 2800000,
		.max_uV = 3000000,
		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
	},
	.num_consumer_supplies = ARRAY_SIZE(imote2_sensor_3_con),
	.consumer_supplies = imote2_sensor_3_con,
},
};

and relevant association with a regulator driver.

Now in the case of i2c devices, the struct device  pointer is created
somewhat later and isn't readily available.

I think the struct device pointer is only used as device instance specific
token in the regulator framework.  If so is there any reason it can't be
relaxed to a void * thus allowing something else to be used in i2c drivers?

If so what could actually be used?  Unfortunately all the data elements
of i2c_board_info are coppied out (rather than a pointer to the original
structure being used) so that's not currently available.  I guess it could
be made so at the cost of a single pointer in each i2c_client structure.

So the question is how would people prefer to do this?

Thanks,

--
Jonathan Cameron
