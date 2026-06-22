local powerline(x) = { style: 'powerline', powerline_symbol: '' } + x;
local chip(x) = { style: 'diamond', leading_diamond: '', trailing_diamond: '' } + x;
local plain(x) = { style: 'plain' } + x;

{
  '$schema': 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json',
  upgrade: {
    source: 'cdn',
    interval: '168h',
    auto: false,
    notice: false,
  },
  blocks: [
    {
      type: 'prompt',
      alignment: 'left',
      force: true,
      segments: [],
      newline: false,
    },
    {
      type: 'prompt',
      alignment: 'left',
      newline: true,
      segments: [
        powerline({
          type: 'root',
          template: '  ',
          foreground: '#000000',
          background: '#0000ff',
        }),
        powerline({
          type: 'path',
          properties: {
            style: 'full',
          },
          template: ' {{ .Path }} ',
          foreground: '#ffffff',
          background: '#0000ff',
        }),
        powerline({
          type: 'git',
          foreground: '#193549',
          background: '#24d55c',
          background_templates: [
            '{{ if or (.Working.Changed) (.Staging.Changed) }}#FFEB3B{{ end }}',
            '{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFCC80{{ end }}',
            '{{ if gt .Ahead 0 }}#B388FF{{ end }}',
            '{{ if gt .Behind 0 }}#B388FB{{ end }}',
          ],
          template: ' {{ .UpstreamIcon }} {{ .HEAD }} {{ .LatestTag }} {{if .BranchStatus }}{{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}',
          properties: {
            fetch_status: true,
            fetch_upstream_icon: true,
            mapped_branches: {
              'feat/*': '🚀 ',
              'bug/*': '🐛 ',
            },
          },
        }),
      ],
    },
    {
      type: 'prompt',
      alignment: 'right',
      segments: [
        chip({
          type: 'aws',
          foreground: '#ffffff',
          background: '#FFA400',
          template: '  {{.Profile}}{{if .Region}}@{{.Region}}{{end}}',
        }),
        chip({
          type: 'kubectl',
          foreground: '#000000',
          background: '#ebcc34',
          template: ' ⎈ {{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}} ',
          options: {
            context_aliases: {
              'arn:aws:eks:eu-west-1:1234567890:cluster/posh': 'posh',
            },
            cluster_aliases: {
              'arn:aws:eks:eu-west-1:1234567890:cluster/posh': 'posh-cluster',
            },
          },
        }),
        chip({
          type: 'docker',
          foreground: '#000000',
          background: '#0B59E7',
          template: '  {{ .Context }} ',
        }),
        chip({
          template: ' {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }} ',
          foreground: '#ffffff',
          background: '#7FD5EA',
          type: 'go',
        }),
        chip({
          properties: {
            time_format: '15:04:05',
          },
          template: ' {{ .CurrentDate | date .Format }} ',
          foreground: '#000000',
          background: '#ffffff',
          type: 'time',
        }),
        chip({
          type: 'executiontime',
          foreground: '#ffffff',
          background: '#8800dd',
          template: ' {{ .FormattedMs }} ',
          properties: {
            threshold: 1500,
            style: 'austin',
          },
        }),
      ],
    },
    {
      type: 'prompt',
      alignment: 'left',
      segments: [
        plain({
          type: 'status',
          foreground: '#FF5252',
          template: ' {{ .String }} ',
          properties: {
            status_template: '{{ .Code }}',
            always_enabled: false,
          },
        }),
        plain({
          properties: {
            always_enabled: true,
          },
          template: '❯ ',
          foreground: '#D4E157',
          type: 'status',
          foreground_templates: [
            '{{ if gt .Code 0 }}#FF5252{{ end }}',
          ],
        }),
      ],
      newline: true,
    },
  ],
}
