From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: fix some broken references due to txt->rst
 renames
Date: Thu, 20 Jun 2019 14:14:40 -0600
Message-ID: <20190620141440.5e352241@lwn.net>
References: <6f09587b7678f2fb378d736f45a02ffa9412cc99.1560864716.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f09587b7678f2fb378d736f45a02ffa9412cc99.1560864716.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Otto Sabart <ottosabart@seberm.com>, Li Yang <leoyang.li@nxp.com>, Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 18 Jun 2019 10:33:58 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> here are three left-overs from the recent file renames,
> probably due to some other conflicting patch.
> 
> Fix them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
> 
> This patch is against today's next-20190617 branch. Not sure if it
> will apply cleanly at -docs tree. If not,  Please let me know for me to
> split.

Indeed it does not; one of the files being patched doesn't even exist in
my world...

jon
