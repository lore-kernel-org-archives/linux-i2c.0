From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 06/10] mfd: Add core driver for AD242x A2B transceivers
Date: Tue, 17 Dec 2019 20:36:40 +0100
Message-ID: <ff062a37-e07d-3d6c-7fa5-9e6dc74b1aa9@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org> <20191217133952.GJ18955@dell>
 <20191217134617.GK18955@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217134617.GK18955@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

On 12/17/19 2:46 PM, Lee Jones wrote:
> One thing I should mention upfront; there is too much code "doing
> things" in here for it to be an MFD.  MFDs don't care about; syncs,
> slots, TDM, inverting lines, upstreams, downstreams, etc etc etc.
> Anything remotely technical or functional, the code that "does things"
> should be moved out to the relevant areas.  In the case of this
> device, that's looking like one of the Audio related subsystems.

Okay, that's good to know.

I in fact considered that when I started working on it; after all, A2B 
stands for "automotive audio bus". The reason why I didn't do it was the 
fact that these devices certainly do have multiple functions, where 
audio is just one of them, and there needs to be a 'top-level' layer 
that enables all these functions and does the node discovery etc. Hence 
I thought it's cleaner to separate things that way.

I can move things over to the ASoC layer for the next iteration, and 
then maybe also merge the codec driver with the baseline drivers. Let's 
see how this looks like then.


Thanks,
Daniel
