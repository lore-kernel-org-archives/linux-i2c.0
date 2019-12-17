From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 10/10] ASoC: Add codec component for AD242x
 nodes
Date: Tue, 17 Dec 2019 13:28:31 -0600
Message-ID: <0565e5cd-9a6e-db65-0632-0bc1aa1d79db@linux.intel.com>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-12-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209183511.3576038-12-daniel@zonque.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org



On 12/9/19 12:35 PM, Daniel Mack wrote:
> This driver makes AD242x nodes available as DAIs in ASoC topologies.
> 
> The hardware allows multiple TDM channel modes and bitdepths, but
> as these modes have influence in the timing calculations at discovery
> time, the mode in that the will be used in needs to be configured

the mode in that the <what> will be used in?

You should probably reword this for clarity.

> statically in the devicetree.

> +	if (ad242x_node_is_master(priv->node) &&
> +	   ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)) {
> +		dev_err(component->dev, "master node must be clock slave\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!ad242x_node_is_master(priv->node) &&
> +	   ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)) {
> +		dev_err(component->dev, "slave node must be clock master\n");
> +		return -EINVAL;
> +	}

It was my understanding that the master node provides the clock to the 
bus, so not sure how it could be a clock slave, and conversely how a 
slave node could provide a clock to the bus?


> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		if (priv->node->tdm_slot_size != 16)
> +			return -EINVAL;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		if (priv->node->tdm_slot_size != 32)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

how does this work for PDM data?

is the PDM data packed into a regular TDM slot?

> +
> +	if (priv->pdm[index]) {
> +		if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +			return -EINVAL;
> +
> +		if (index == 0) {
> +			val = AD242X_PDMCTL_PDM0EN;
> +			mask = AD242X_PDMCTL_PDM0EN | AD242X_PDMCTL_PDM0SLOTS;
> +		} else {
> +			val = AD242X_PDMCTL_PDM1EN;
> +			mask = AD242X_PDMCTL_PDM1EN | AD242X_PDMCTL_PDM1SLOTS;
> +		}
> +
> +		switch (params_channels(params)) {
> +		case 1:
> +			break;
> +		case 2:
> +			val = mask;
> +			break;

A comment wouldn't hurt here...
