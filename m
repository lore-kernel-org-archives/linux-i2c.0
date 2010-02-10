From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
Date: Wed, 10 Feb 2010 07:14:26 -0700
Message-ID: <fa686aa41002100614l76bff396ved847c0b0a4c71ff@mail.gmail.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
	<4B7285D5.9060008@grandegger.com>
	<20100210213203.48a9105e.sfr@canb.auug.org.au>
	<4B729043.9080303@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4B729043.9080303-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 10, 2010 at 3:53 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wr=
ote:
> Stephen Rothwell wrote:
>> Hi Wolfgang,
>>
>> On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg-5Yr1BZd7O63KJghVJtBX7w@public.gmane.org=
m> wrote:
>>>> __devinitdata goes at the end, immediately before the '=3D'. =A0Ditto
>>>> throughout the file.
>>> This made a difference and revealed section mismatches. "const" seems to
>>> be incompatible with "__devinitdata".
>>
>> Maybe try no "const" and "__devinitconst" (I am not sure if both will
>> work).
>
> Yes, that works, even together with "const". To avoid rolling out the
> whole patch series again, I can prepare a follow-up patch fixing this iss=
ue.

Nah, just resend this one patch.

g.
