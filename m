From: Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [RFC PATCH 8/9] i2c: i2c-mux: Allow for NULL select callback
Date: Tue, 1 Mar 2016 22:38:35 +0200
Message-ID: <CAEnQRZBZyGwhheHz_Smo_5kv36fpenM9HD+ab-u1qsfko0mvQQ@mail.gmail.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	<1455810794-3188-9-git-send-email-daniel.baluta@intel.com>
	<20160301203015.GC1488@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160301203015.GC1488@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ge Gao <ggao@invensense.com>, Adriana Reus <adi.reus@gmail.com>, Crt Mori <cmo@melexis.com>, Michael Welling <mwelling@ieee.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 1, 2016 at 10:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Feb 18, 2016 at 05:53:13PM +0200, Daniel Baluta wrote:
>> From: Adriana Reus <adriana.reus@intel.com>
>>
>> Add a check in i2c_mux_master_xfer before calling the select callback.
>> This is necessary so that NULL callbacks can be safely registered.
>>
>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>
> Hmm, rather than supporting that in the core, I'd prefer to have the
> driver pass an empty function instead. Then, in the driver, we can have
> a comment explaining the special situation.

Agree. This seems a better idea forcing the user to explain the situation :).
