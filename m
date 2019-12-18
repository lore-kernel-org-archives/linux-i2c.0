From: Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH 00/10] mfd: Add support for Analog Devices
 A2B transceiver
Date: Wed, 18 Dec 2019 10:53:02 +0100
Message-ID: <22803ea0-0c4a-b096-ec11-5e8f5c27d8d3@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <cb86a793-014a-1acf-c144-f9014ac0a0ac@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb86a793-014a-1acf-c144-f9014ac0a0ac@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 12/17/19 8:29 PM, Pierre-Louis Bossart wrote:
>> Transceivers can both receive and provide audio, and streams can be
>> routed from one node to any other, including many others. The tricky
>> bit is how to expose the audio routing in DT in a sane way.
>> The way it is implemented here, the slave nodes specify the number of
>> slots they each consume and generate, and which thereof they forward
>> from one side to the other. This mimics the internal register
>> structure and should allow for even exotic setups.
> 
> It was my understanding that the A2B bus is bidirectional but with
> separate time windows allocated for host->device and device->host
> transmission. The wording seems to hint at device-to-device
> communication but I wonder if this is really what you meant.

Yes, audio frames can be exchanged between two slave nodes without
interaction by the master node. I'm not sure what the best way is to
describe that in DT really, but as the hardware is capable of doing it,
there must be a way to enable such setups.


Thanks,
Daniel
