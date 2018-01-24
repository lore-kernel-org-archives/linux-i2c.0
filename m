From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] i2c: davinci: fix the cpufreq transition
Date: Tue, 23 Jan 2018 21:01:54 -0600
Message-ID: <dcd94db0-37b0-5a31-6a36-facdf7f58ed3@lechnology.com>
References: <20180122144258.13627-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180122144258.13627-1-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On 01/22/2018 08:42 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> i2c_davinci_cpufreq_transition() is implemented in a way that will
> block if it ever gets called while no transfer is in progress.
> 
> Not only that, but reinit_completion() is never called for xfr_complete.
> 
> Use the fact that cpufreq uses an srcu_notifier (running in process
> context) for transitions and that the bus_lock is taken during the call
> to master_xfer() and simplify the code by removing the transfer
> completion entirely and protecting i2c_davinci_cpufreq_transition()
> with i2c_lock/unlock_adapter().
> 
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Tested that it fixes the lockup when there is no active transfer.

Tested-by: David Lechner <david@lechnology.com>
