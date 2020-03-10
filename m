From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
Date: Tue, 10 Mar 2020 08:35:11 -0700
Message-ID: <158385451115.149997.17354220554214087646@swboyd.mtv.corp.google.com>
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-2-swboyd@chromium.org> <20200310094159.GG1987@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200310094159.GG1987@ninjato>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang (2020-03-10 02:42:00)
> On Tue, Feb 04, 2020 at 11:31:50AM -0800, Stephen Boyd wrote:
> > We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> > should take care of this for us. Just use 0 instead so that we use the
> > flags from the firmware. Also, remove specify dev_name() for the irq
> > name so that we can get better information in /proc/interrupts about
> > which device is generating interrupts.
> >=20
> > Cc: Girish Mahadevan <girishm@codeaurora.org>
> > Cc: Dilip Kota <dkota@codeaurora.org>
> > Cc: Alok Chauhan <alokc@codeaurora.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> All patches look good, but this one doesn't build because dev is defined
> in the next patch only. I also can't apply patch 2 before 1, so please
> rebase and resend.

Ok.
