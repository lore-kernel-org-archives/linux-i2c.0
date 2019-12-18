From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 10/10] ASoC: Add codec component for AD242x
 nodes
Date: Wed, 18 Dec 2019 09:32:40 -0600
Message-ID: <ff0e2420-a2c6-17e7-2761-f6544e2c0cb7@linux.intel.com>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-12-daniel@zonque.org>
 <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
 <35e7e6e7-7c70-785c-bdf3-79089134699e@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35e7e6e7-7c70-785c-bdf3-79089134699e@zonque.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org



On 12/18/19 3:49 AM, Daniel Mack wrote:
> Hi,
> 
> On 12/17/19 8:28 PM, Pierre-Louis Bossart wrote:
>> On 12/9/19 12:35 PM, Daniel Mack wrote:
> 
>>> +    if (!ad242x_node_is_master(priv->node) &&
>>> +       ((format & SND_SOC_DAIFMT_MASTER_MASK) !=
>>> SND_SOC_DAIFMT_CBM_CFM)) {
>>> +        dev_err(component->dev, "slave node must be clock master\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> It was my understanding that the master node provides the clock to the
>> bus, so not sure how it could be a clock slave, and conversely how a
>> slave node could provide a clock to the bus?
> 
> The slave nodes receive the A2B clock from the master node and then
> produce digital audio output that is sent to other components such as
> codecs. Hence, in ASoC terms, they are the clock master.
> 
> Likewise, as the master node is receiving its clock from other
> components, it has to be a clock slave in the audio network.
> 
> Does that make sense?

Your slave node acts as a bridge then, but it seems you don't model the 
bus-facing interface, which has to follow the master clock. Or do you?

Likewise the master has an 'SOC-facing' interface and a bus-facing 
interface. it *could* be master on both if ASRC was supported. The point 
is that the bus-facing interface is not clock slave.
