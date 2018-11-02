From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix runtime PM mismatch with child devices
Date: Fri, 02 Nov 2018 13:56:29 -0700
Message-ID: <154119218930.88331.3706147618288145520@swboyd.mtv.corp.google.com>
References: <20181102183537.72334-1-swboyd@chromium.org>
 <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-i2c@vger.kernel.org, alokc@codeaurora.org, Evan Green <evgreen@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Doug Anderson (2018-11-02 13:43:25)
> Thanks for the fix.  It looks good, but can you also swap the
> pm_runtime_disable() and i2c_del_adapter() calls in geni_i2c_remove()
> to match?
> =


Good catch. Will resend with that.
