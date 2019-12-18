From: Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH 10/10] ASoC: Add codec component for AD242x
 nodes
Date: Wed, 18 Dec 2019 10:49:38 +0100
Message-ID: <35e7e6e7-7c70-785c-bdf3-79089134699e@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-12-daniel@zonque.org>
 <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 12/17/19 8:28 PM, Pierre-Louis Bossart wrote:
> On 12/9/19 12:35 PM, Daniel Mack wrote:

>> +    if (!ad242x_node_is_master(priv->node) &&
>> +       ((format & SND_SOC_DAIFMT_MASTER_MASK) !=
>> SND_SOC_DAIFMT_CBM_CFM)) {
>> +        dev_err(component->dev, "slave node must be clock master\n");
>> +        return -EINVAL;
>> +    }
> 
> It was my understanding that the master node provides the clock to the
> bus, so not sure how it could be a clock slave, and conversely how a
> slave node could provide a clock to the bus?

The slave nodes receive the A2B clock from the master node and then
produce digital audio output that is sent to other components such as
codecs. Hence, in ASoC terms, they are the clock master.

Likewise, as the master node is receiving its clock from other
components, it has to be a clock slave in the audio network.

Does that make sense?

>> +    switch (params_format(params)) {
>> +    case SNDRV_PCM_FORMAT_S16_LE:
>> +        if (priv->node->tdm_slot_size != 16)
>> +            return -EINVAL;
>> +        break;
>> +    case SNDRV_PCM_FORMAT_S32_LE:
>> +        if (priv->node->tdm_slot_size != 32)
>> +            return -EINVAL;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
> 
> how does this work for PDM data?
> 
> is the PDM data packed into a regular TDM slot?

Yes. But I admit this needs some more testing. We're still working on
the hardware that uses this. I'll revisit this.

And I'll also add a lot more comments all over the place, as also
requested by Lee.


Thanks,
Daniel
