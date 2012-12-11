From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: I2C and devicetrees
Date: Tue, 11 Dec 2012 13:56:08 -0700
Message-ID: <50C79DE8.2090201@wwwdotorg.org>
References: <201212052336.24233.PeterHuewe@gmx.de> <CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMhUVwB4+kuCA8hSmfhoVzkznNbjj6hjngDMaQkB83WqjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12/11/2012 01:21 PM, Olof Johansson wrote:
> [+devicetree-discuss]
> 
> On Wed, Dec 5, 2012 at 2:36 PM, Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org> wrote:
>> Hi,
>>
>> I have a short question about the relations between i2c and devicetrees.
>>
>> I was wondering
>> is the device part of the compatible string of a (trivial) i2c device
>> instanciated via devicetree _always_ identical to name in i2c_client.name ?
>> Or can it be somehow different?
> 
> It can be different, but the driver will then need to add a OF table
> that matches the probing. By default the i2c/dt core code will strip
> off the vendor prefix (before ",") and try probing with the rest of
> the device name. If that doesn't match the client name, that is when
> you need the additional table.

While relying on the prefix stripping works, I think I recall Grant
mentioning that people shouldn't rely on it - namely that any I2C device
that gets instantiated from DT should contain the OF match table
explicitly. I CC'd Grant in case I'm mis-quoting him.
