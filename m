From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Date: Tue, 5 Nov 2019 13:12:22 +0530
Message-ID: <CAKfKVtEwHcydp=+hNhG91h3qbMoYOPq7jEYjbuAVrWXT53DC3Q@mail.gmail.com>
References: <20190219012447.5900-1-sxauwsk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219012447.5900-1-sxauwsk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shikai Wang <sxauwsk@163.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shikai,

On Tue, Feb 19, 2019 at 8:19 AM Shikai Wang <sxauwsk@163.com> wrote:
>
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.
>
I am missing the issue that you are facing.
You are having a multimaster scenario and getting arbitration lost.

the current code would attempt a retry did that lead to any issues?

Can you explain the issue that you are facing?
