From: Maxime COQUELIN <maxime.coquelin@st.com>
Subject: Re: [PATCH v4 0/4] Add I2C support to ST SoCs
Date: Thu, 10 Oct 2013 15:33:43 +0200
Message-ID: <5256ACB7.7050302@st.com>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
 <525675B6.4080404@st.com> <20131010100354.GE2638@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131010100354.GE2638@katana>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Stephen GALLIMORE <stephen.gallimore@st.com>, Stuart MENEFY <stuart.menefy@st.com>, Lee Jones <lee.jones@linaro.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>
List-Id: linux-i2c@vger.kernel.org


On 10/10/2013 12:03 PM, Wolfram Sang wrote:
>>> Changes since v3:
>>>     - Switch back to vendor specific DT properties regarding the anti-glitch
>>>       filter configuration, as this IP is the only one having such a filter.
>> Do you agree to keep these properties vendor-specifics?
> My preference is generic bindings. There are no other users right now,
> yet there might be in the future. At least with something similar enough
> that the bindings will apply. Was hoping for some additional input,
> though, but I am not depending on it.
I have to push another revision to change the IRQ flags as reported by 
Stephen G.
I will also revert to generic bindings in this revision.
For their documentation, I will add it as soon as you will have created 
the DT binding documentation of I2C.

Is it okay for you?
>
>> If so, could you take this series for v3.13?
> Sure, if it passes the second review...
For sure!

Regards,
Maxime
