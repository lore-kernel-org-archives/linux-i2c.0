From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] i2c: cros_ec: Remove EC_I2C_FLAG_10BIT
Date: Tue, 24 Jun 2014 09:53:17 -0600
Message-ID: <CAPnjgZ2_T46YgQnS1WvG7Wf8oPREuZmayE+_JkTzuEUVtAA=OA@mail.gmail.com>
References: <1403558406-14519-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403558406-14519-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Dave Jones <davej@redhat.com>, Randall Spangler <rspangler@chromium.org>, Samuel Ortiz <sameo@linux.intel.com>, Bill Richardson <wfrichar@chromium.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 23 June 2014 15:20, Doug Anderson <dianders@chromium.org> wrote:
> In <https://lkml.org/lkml/2014/6/10/265> pointed out that the 10-bit
> flag in the cros_ec_tunnel was useless.  It went into a 16-bit flags
> field but was defined at (1 << 16).
>
> Since we have no 10-bit i2c devices on the other side of the tunnel on
> any known devices this was never a problem.  Until we do it makes
> sense to remove this code.  On the EC side the code to handle this
> flag was removed in <https://chromium-review.googlesource.com/204162>.
>
> Reported-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Funny. We certainly don't use it.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
