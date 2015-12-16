From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 16 Dec 2015 11:04:54 +0200
Message-ID: <20151216090454.GL1762@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <CAPw-ZT=TcvneyS69GjWe8sFR2hBTpHUUabu8Y5Feup89MwQWQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPw-ZT=TcvneyS69GjWe8sFR2hBTpHUUabu8Y5Feup89MwQWQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, wsa@the-dreams.de, Ken Xue <Ken.Xue@amd.com>, Jeff.Wu@amd.com, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Masters <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Duran, Leo" <leo.duran@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 15, 2015 at 11:20:03AM -0800, Loc Ho wrote:
> Can we not just add an AML method that will return the operation clock
> frequency that the I2C driver can use? If the method doesn't existed,
> we will just bail and do nothing or assume what ever default behavior?

Why would you add yet another method? There already are existing ACPI
*CNT methods that you can use, and are used in systems out there.
