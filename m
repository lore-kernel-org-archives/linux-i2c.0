From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] i2c: davinci: fix the cpufreq transition
Date: Tue, 23 Jan 2018 18:08:57 +0530
Message-ID: <8323a87f-93fb-c1fd-4098-e47f0fcf5859@ti.com>
References: <20180122144258.13627-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180122144258.13627-1-brgl@bgdev.pl>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, David Lechner <david@lechnology.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday 22 January 2018 08:12 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> i2c_davinci_cpufreq_transition() is implemented in a way that will
> block if it ever gets called while no transfer is in progress.

true!

> 
> Not only that, but reinit_completion() is never called for xfr_complete.

reinit_completion() use is must only with complete_all(). At least that
bug is not obvious so needs more detail to be added here.

> Use the fact that cpufreq uses an srcu_notifier (running in process
> context) for transitions and that the bus_lock is taken during the call
> to master_xfer() and simplify the code by removing the transfer
> completion entirely and protecting i2c_davinci_cpufreq_transition()
> with i2c_lock/unlock_adapter().
> 
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I assume you tested this on a board where I2C-controlled PMIC changes
voltage during CPUfreq (DA850 LogicPD EVM should have this hardware
support).

Perhaps also add:

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")

Apart from that:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
