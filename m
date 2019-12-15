From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 07/10] i2c: Add driver for AD242x bus controller
Date: Sun, 15 Dec 2019 21:27:18 +0100
Message-ID: <482316ef-775a-cb7b-015e-e00463503e6b@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-9-daniel@zonque.org>
 <64adf5d7-754a-f1da-aa9b-11579c5a2780@lucaceresoli.net>
 <20191212163315.GA3932@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212163315.GA3932@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org

Hi,

Thanks for the review!

On 12/12/2019 5:33 pm, Wolfram Sang wrote:
> Hi Luca,
> 
> thanks for the review!
> 
>> good, but I think there's a problem in this function. A "normal"
>> master_xfer function issues a repeated start between one msg and the
>> next one, at least in the typical case where all msgs have the same
>> slave address. Your implementation breaks repeated start. At first sight
>> we might need more complex code here to coalesce all consecutive msgs
>> with the same address into a single i2c_transfer() call.
> 
> Note that it is by far the standard case that all messages in a transfer
> have the same client address (99,999%?). But technically, this is not a
> requirement and the repeated start on the bus is totally independent of
> the addresses used. It is just a master wanting to send without being
> interrupted by another master.

I'm not quite sure I understand.

Let's assume the following setup. An i2c client (some driver code) is
sending a list of messages to the a2b xfer function, which in turn is
logically connected to a 'real' i2c bus master that'll put the data on
the wire.

The a2b code has to tell the 'master node' the final destination of the
payload by programming registers on its primary i2c address, and then
forwards the messages to its secondary i2c address. The layout of the
messages don't change, and neither do the flags; i2c messages are being
sent as i2c messages, except their addresses are changed, a bit like NAT
in networking. That procedure is described on page 3-4 of the TRM,
"Remote Peripheral I2C Accesses".

The 'real' i2c master that handles the hardware bus is responsible for
adding start conditions, and as the messages as such are untouched, I
believe it should do the right thing. The code in my xfer functions
merely suppresses reprogramming remote addresses by remembering the last
one that was used, but that is independent of the start conditions on
the wire.

Maybe I'm missing anything. Could you provide an example that explains
in which case this approach would leads to issues?


Thanks,
Daniel
