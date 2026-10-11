### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lab-report", "module1"]
#> title = "📄 TL1: Geradores de Corrente Contínua"
#> layout = "layout.jlhtml"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 72e6c5e3-8d5c-4893-a3a0-1e9e6559156e
using PlutoUI, PlutoTeachingTools, Handcalcs, Plots, DataFrames, Statistics
# Short packages description:
  # PlutoUI.jl, para adicionar interactividade ao notebook (@bind)
  # PlutoTeachingTools.jl, para melhorar a apresentação (aside, TableOfContents, ...)
  # Handcalcs.jl, para mostrar cálculos em LaTeX (fórmula, substituição, resultado)
  # Plots.jl, para traçar as curvas características
  # DataFrames.jl, para apresentar os dados e resultados em tabelas
  # Statistics.jl, para médias (regressões lineares)

# ╔═╡ 49477e5b-ec8b-4dae-8a7c-cf86c4f283ba
md"**`Link para o Notebook:`** [`TL1_MEII_2627_51N1_G3.jl`](https://gualdrapa.github.io/ISEL_ME-2/TL1_MEII_2627_51N1_G3.jl)"

# ╔═╡ cb2aba91-328d-453c-a6a4-b58bdaac45e6
md"""
---

$(html"<p><center style='font-size:19px;font-family:monospace'><b>MÁQUINAS ELÉCTRICAS DE CORRENTE CONTÍNUA</b></center></p>")

$(html"<p><center style='font-size:19px;font-family:monospace'>RELATÓRIO</center></p>")

$$\colorbox{Bittersweet}{\textcolor{white}{\textbf{TL1: Geradores de Corrente Contínua}}}$$

---
"""

# ╔═╡ 5b4dfc55-4b26-45fc-aee7-b74195ac2c73
md"""
$(html"<p><center style='line-height:1.7'><b>Instituto Superior de Engenharia de Lisboa</b><br>Instituto Politécnico de Lisboa<br>Departamento de Engenharia Electrotécnica, Energia e Automação Industrial (DEEEA)</center></p>")
"""

# ╔═╡ ead31e42-3ea5-4833-9659-43543197bb1f


# ╔═╡ 8d840560-a311-4f8b-8e2d-f52f5818fc15
HTML("""
<div style='display:grid; grid-template-columns:1fr 1fr; gap:2rem; line-height:1.65; text-align:center'>
<div>
<div style='display:inline-block; text-align:left'>
<b>Alunos</b><br>
Bruno Ferros · A51622<br>
Diogo Rocha · A47622<br>
Rafael Carvalho · A48870<br>
Tiago Soares · A47610
</div>
</div>
<div>
<div style='display:inline-block; text-align:left'>
Professor Ricardo Luís<br>
<b>Ano lectivo:</b> 2026/2027<br>
<b>Turma:</b> 51N1<br>
<b>Grupo:</b> 3<br>
<b>Data:</b> 16 de Outubro de 2026
</div>
</div>
</div>
""")

# ╔═╡ b18d9dc8-2920-43ac-a9bf-c8b989cc5ef2
# ╠═╡ disabled = true
#=╠═╡
aside(md"""
!!! info "Nota:"
	As secções assinaladas com 📌 devem ser completadas ou confirmadas pelo grupo. As secções assinaladas com 💻 contêm dados ou parâmetros editáveis, dos quais dependem as tabelas e os gráficos seguintes.

	As interpretações, discussão e conclusões ficam a cargo do grupo (ver *Declaração de uso de GenAI* no final).
""", v_offset=-60)
  ╠═╡ =#

# ╔═╡ 3c751441-672e-4bcc-aa46-47f50b4ddb1b
md"""
# 1 - Introdução
"""

# ╔═╡ d7f65207-6978-4490-83b0-129356004c47
md"""
O presente relatório descreve o Trabalho Laboratorial 1 (TL1) da unidade curricular de Máquinas Eléctricas II, dedicado ao estudo do gerador de corrente contínua. Através de ensaios em vazio e em carga, com diferentes tipos de excitação, procura-se obter e comparar as curvas características que descrevem o funcionamento da máquina.

Este relatório está organizado da seguinte forma. Na [secção 1](#1---Introdução) apresentam-se o enquadramento e os objectivos. A [secção 2](#2---Procedimento-de-ensaio) descreve os esquemas de ligações, o material utilizado e a condução dos ensaios. Na [secção 3](#3---Resultados-experimentais) apresentam-se os resultados experimentais, e na [secção 4](#4---Análise-de-resultados) faz-se o seu tratamento e análise. Por fim, a [secção 5](#5---Conclusões) reúne as conclusões.
"""

# ╔═╡ c8d37d56-5780-4278-b810-5b013c7a3994
md"""
## 1.1 - Enquadramento

As máquinas de corrente contínua (CC) são dispositivos electromecânicos que convertem energia mecânica em energia eléctrica (geradores) ou vice-versa (motores)[^Chapman].

Quanto ao modo como o campo magnético é criado, os geradores CC classificam-se em dois grupos principais:

- **Gerador CC de excitação separada (ou independente)**, em que o circuito indutor é alimentado por uma fonte CC externa;
- **Geradores CC autoexcitados**, em que o(s) circuito(s) indutor(es) é(são) alimentado(s) pela tensão produzida no induzido. Podem ainda ser subdivididos em derivação (*shunt*), série e composto (*compound*).

Para uma análise completa do gerador, do(s) seu(s) circuito(s) indutor(es) e do induzido, consideram-se as seguintes curvas características[^RLuis_separshunt][^RLuis_compound]:

- **Característica magnética ou de vazio**, $E_0=f(I_{exc})$, a velocidade constante (relação entre a força electromotriz e a corrente de excitação);
- **Característica externa**, $U=f(I)$, com $n$ e $R_c$ (ou $I_{exc}$) constantes (relação entre a tensão nos terminais e a corrente de carga);
- **Característica de regulação**, $I_{exc}=f(I)$, com $U$ e $n$ constantes.

Este trabalho laboratorial foca-se na obtenção e análise experimental destas curvas para diferentes configurações de geradores CC: excitação separada (ou independente), derivação (*shunt*) e composta (*compound*), em longa derivação e com fluxo aditivo e subtractivo.
"""

# ╔═╡ 0c244854-420a-4ea4-ad0a-b9d4e8c12b88
md"""
## 1.2 - Objectivos
"""

# ╔═╡ de8a4879-e2e3-45ff-88b0-b652cbd5c421
md"""
Este trabalho laboratorial tem como finalidade a aquisição de competências práticas e teóricas no que diz respeito aos geradores de corrente contínua. Os objectivos específicos, definidos no enunciado do trabalho[^RLuis_enunciados], são:

1. Conceber e executar esquemas eléctricos de geradores de CC;
1. Operar geradores CC com diferentes tipos de excitação;
1. Conduzir ensaios para obtenção de curvas características de funcionamento de geradores CC;
1. Distinguir os processos de regulação da tensão de saída de um gerador CC;
1. Analisar comparativamente as curvas características de geradores CC.

Em concreto, este trabalho experimental (TL1) consistiu nos seguintes ensaios:

- **TL1.1**: ensaio em vazio (duas velocidades) e em carga do gerador de excitação separada, realizado no dia 24 de Setembro de 2026;
- **TL1.2**: ensaio em carga do gerador autoexcitado em excitação derivação e em excitação composta (aditiva e subtractiva), realizado no dia 1 de Outubro de 2026.

Ambos os ensaios foram realizados na bancada 3 do Laboratório de Máquinas Eléctricas do ISEL.
"""

# ╔═╡ 669f3dfc-5138-4ed7-8606-0c47a7680de3
md"""
# 2 - Procedimento de ensaio
"""

# ╔═╡ 1edf5a6b-5a27-495d-869a-b4092c333ca1
md"""
Neste capítulo descreve-se a forma como os ensaios foram realizados, com o detalhe necessário para que possam ser repetidos. Os ensaios do TL1.1 (24 de Setembro de 2026) e do TL1.2 (1 de Outubro de 2026) decorreram na bancada 3 do Laboratório de Máquinas Eléctricas do ISEL, com o gerador accionado por uma máquina acoplada ao seu veio, a velocidade mantida constante através de um variador de frequência.

Apresentam-se, por esta ordem, os esquemas de ligações de cada montagem [secção 2.1](#sec21), o material utilizado [secção 2.2](#sec22) e a condução de cada ensaio [secção 2.3](#sec23).
"""

# ╔═╡ 3220fabe-078a-4e15-ad9b-e1eaea290d93
html"<span id='sec21'></span>"

# ╔═╡ ef1805c1-1ca7-441e-803a-a45bf2414e26
html"<span id='sec22'></span>"

# ╔═╡ b258eeb3-248a-466a-b6e3-f323e630d92d
html"<span id='sec23'></span>"

# ╔═╡ e4c39c28-c16e-46ce-8adb-591fc2811a32
html"<span id='sec3'></span>"

# ╔═╡ 97f3e468-2f8b-4835-a58d-f7f6be44fcd7
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ 81d39162-63a3-40fb-9146-03102e8f743f
html"<span id='sec31'></span>"

# ╔═╡ 87db8358-81b4-440e-8ec7-750e24afd80b
begin
	# Resistências medidas com a máquina desligada (Ω)
	Ri_11  = 1.0      # GA-HB (induzido), sessão TL1.1
	Rjk_11 = 366.0    # J-K, sessão TL1.1
	Rc_11  = 767.0    # "Rc" na folha de cálculo (📌 confirmar o que representa)

	Ri_12  = 0.9      # GA-HB (induzido), sessão TL1.2
	Rd_12  = 332.0    # J-K, sessão TL1.2: na folha está 0,332 (assumido kΩ; U/Id em vazio ≈ 334 Ω)
	Rs_12  = 0.2      # E-F (enrolamento série), sessão TL1.2

	In_ch  = 29.0     # A, corrente nominal indicada na folha de cálculo ("29 (In)"; 📌 confirmar na chapa)
end;

# ╔═╡ e39d4df6-f8f3-4563-91e7-995e95bce75d
DataFrame("Terminais" => ["GA-HB (induzido)", "J-K", "Rc", "GA-HB (induzido)", "J-K (derivação)", "E-F (série)"],
	"Sessão" => ["TL1.1", "TL1.1", "TL1.1", "TL1.2", "TL1.2", "TL1.2"],
	"R [Ω]" => [Ri_11, Rjk_11, Rc_11, Ri_12, Rd_12, Rs_12])

# ╔═╡ 47fc0cdd-f1fa-4e51-bb0f-3b8f36d93f66
html"<span id='sec32'></span>"

# ╔═╡ cc709138-586e-452b-9e50-b8fa5965d6e6
begin
	# Ensaio em vazio, velocidade n₁ (ordem de registo)
	n_vz1    = 750      # rpm
	Iexc_vz1 = [0.67, 0.568, 0.492, 0.463, 0.436, 0.416, 0.399, 0.369, 0.331, 0.301, 0.269, 0.242, 0.216, 0.207]   # A
	E0_vz1   = [106.8, 100.3, 93.4, 90.0, 86.6, 83.9, 81.4, 76.5, 70.2, 64.6, 58.7, 53.6, 48.3, 46.3]             # V
	Er_vz1   = 3.14     # V, magnetismo remanescente (Iexc = 0)

	# Ensaio em vazio, velocidade n₂
	n_vz2    = 1500     # rpm
	Iexc_vz2 = [0.652, 0.602, 0.553, 0.514, 0.481, 0.452, 0.409, 0.378, 0.328, 0.298, 0.274, 0.246, 0.227, 0.206]   # A
	E0_vz2   = [211.0, 205.0, 197.0, 190.0, 184.0, 175.0, 165.0, 155.0, 138.0, 127.0, 118.0, 108.0, 100.0, 91.0]   # V
	Er_vz2   = 6.27     # V, magnetismo remanescente (Iexc = 0)
end;

# ╔═╡ 4eb20e8d-555b-49fe-b3e5-291a9e489894
begin
	# Curvas ordenadas por Iexc crescente, incluindo o ponto remanente (Iexc = 0)
	o_vz1 = sortperm(Iexc_vz1)
	o_vz2 = sortperm(Iexc_vz2)
	Iexc_c1 = [0.0; Iexc_vz1[o_vz1]]
	E0_c1   = [Er_vz1; E0_vz1[o_vz1]]
	Iexc_c2 = [0.0; Iexc_vz2[o_vz2]]
	E0_c2   = [Er_vz2; E0_vz2[o_vz2]]
end;

# ╔═╡ f0459a1a-8e6b-4615-ae5f-3e753232430d
DataFrame("n [rpm]" => fill(n_vz1, length(E0_vz1)), "I_exc [A]" => Iexc_vz1, "E₀ [V]" => E0_vz1,
	"kφ = E₀/n [V/rpm]" => round.(E0_vz1 ./ n_vz1, digits=4))

# ╔═╡ 820bb91b-7339-4d1b-b7f6-a680ac33716e
DataFrame("n [rpm]" => fill(n_vz2, length(E0_vz2)), "I_exc [A]" => Iexc_vz2, "E₀ [V]" => E0_vz2,
	"kφ = E₀/n [V/rpm]" => round.(E0_vz2 ./ n_vz2, digits=4))

# ╔═╡ 035ff22f-9527-4a03-88c4-12d52bcec829
html"<span id='sec33'></span>"

# ╔═╡ 6402d75e-7467-4b24-8088-a5f690c64cad
begin
	n_c11     = 1500    # rpm (constante)
	Iexc_c11  = 0.206   # A, valor registado na folha (⚠ ver nota abaixo)
	carga_11  = [15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165]                                    # % (caixa de cargas)
	I_c11     = [2.63, 5.27, 7.83, 10.25, 12.61, 14.94, 17.11, 19.33, 22.55, 25.93, 28.79]            # A
	U_c11     = [206.0, 203.0, 199.0, 197.0, 194.0, 191.0, 188.0, 185.0, 181.0, 177.0, 172.0]        # V

	# Observação registada na folha ("Regulação"): 📌 descrever a manobra efectuada
	I_reg_obs = 10.0      # A
	U_reg_obs = 180.0     # V
	f_reg_obs = 47.72     # Hz (variador)
	n_reg_obs = 1415.0    # rpm
end;

# ╔═╡ b366550d-5d21-42a1-99e6-335a846b0085
html"<span id='sec34'></span>"

# ╔═╡ 8f043af8-e8b2-4363-9184-ce2c54ccbd21
begin
	carga_der = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210]   # %
	I_der  = [0.0, 2.45, 4.9, 7.31, 9.62, 11.78, 13.97, 15.95, 17.96, 19.72, 21.43, 23.05, 24.61, 26.15, 26.55]   # A (carga)
	Id_der = [0.635, 0.622, 0.604, 0.591, 0.58, 0.569, 0.559, 0.547, 0.537, 0.524, 0.515, 0.505, 0.491, 0.485, 0.48]   # A (derivação)
	U_der  = [212.0, 207.0, 205.0, 201.0, 199.0, 195.0, 193.0, 189.0, 186.0, 183.0, 180.0, 176.0, 172.0, 170.0, 168.0]   # V
end;

# ╔═╡ 7a8b0221-acee-4c69-a249-9c92f115c2ce
html"<span id='sec35'></span>"

# ╔═╡ e96058f4-4111-40d5-b34f-e5d31e24c9af
begin
	carga_add = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210]   # %
	I_add  = [0.0, 2.25, 4.6, 6.98, 9.25, 11.37, 13.54, 15.53, 17.52, 19.4, 21.24, 21.84, 23.49, 25.85, 26.86]   # A
	Id_add_med = [0.005, 0.003, 0.007, 0.015, 0.022, 0.029, 0.037, 0.044, 0.049, 0.057, 0.064, 0.067, 0.073, 0.083, 0.088]   # A (ver nota)
	U_add  = [200.0, 198.0, 197.0, 194.0, 193.0, 190.0, 188.0, 186.0, 184.0, 181.0, 179.0, 178.0, 176.0, 173.0, 171.0]   # V
end;

# ╔═╡ 38bcbb19-9ecb-48b0-9b59-e10850840f59
DataFrame("Carga [%]" => carga_add, "I [A]" => I_add, "I_d (registado) [A]" => Id_add_med, "U [V]" => U_add)

# ╔═╡ a44a65b7-dade-4a17-a72b-7bcc137c5b99
html"<span id='sec36'></span>"

# ╔═╡ 95c3d564-e6c6-4a85-8305-b96c4c78b246
begin
	carga_sub = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195]   # % (210 % sem registo na folha)
	I_sub  = [0.0, 2.35, 4.73, 7.0, 9.22, 11.12, 13.03, 14.75, 16.27, 17.75, 19.15, 20.3, 21.15, 22.37]   # A
	Id_sub = [0.575, 0.56, 0.549, 0.535, 0.522, 0.51, 0.493, 0.479, 0.462, 0.441, 0.435, 0.419, 0.403, 0.385]   # A
	U_sub  = [203.0, 199.0, 195.0, 190.0, 186.0, 182.0, 177.0, 172.0, 167.0, 162.0, 157.0, 152.0, 146.0, 140.0]   # V
end;

# ╔═╡ 2f927d24-9a80-4747-9415-6bb7e1e9f2f0
DataFrame("Carga [%]" => carga_sub, "I [A]" => I_sub, "I_d [A]" => Id_sub, "U [V]" => U_sub)

# ╔═╡ 1ff09567-c05d-421a-9fe7-628bf0e3c676
html"<span id='sec4'></span>"

# ╔═╡ 2383e560-f955-44d3-94b3-8173e3f647da
md"""
# 4 - Análise de resultados
"""

# ╔═╡ 47892145-d49e-4307-b351-8022af780c66
md"""
Neste capítulo apresentam-se os cálculos efectuados a partir dos dados da secção 3: a proporcionalidade de $E_0$ com a velocidade (secção 4.1), as condições de autoexcitação (4.2), as quedas de tensão em excitação separada e em derivação (4.3 e 4.4), a comparação das características externas (4.5), a regulação de tensão (4.6) e a característica de regulação calculada (4.7).
"""

# ╔═╡ 0cdc7bf8-fb96-462d-a4ca-9a265bbf148a
html"<span id='sec41'></span>"

# ╔═╡ 01f72d8f-c9ba-458c-9163-3162fc2f67b6
md"""
## 4.1 - Característica magnética: proporcionalidade com a velocidade

Em vazio, a força electromotriz induzida é $E_0=k\varphi\,n$[^Chapman]. Espera-se que $E_0$ aumente com $I_{exc}$ (acréscimo de fluxo), com uma zona linear seguida de saturação, e que, para $I_{exc}=0$, subsista uma tensão não nula devido ao magnetismo remanescente. Sendo $k\varphi_0$ função apenas de $I_{exc}$, de $E_0(n_{mag})=k\varphi_0\,n_{mag}$ e $E_0(n)=k\varphi_0\,n$ resulta $E_0(n)=\dfrac{n}{n_{mag}}\,E_0(n_{mag})$[^RLuis_separshunt], isto é, para o mesmo $I_{exc}$ espera-se $E_0\propto n$. Comparou-se $E_0$ a 750 rpm com o valor a 1500 rpm (interpolado) para o mesmo $I_{exc}$:
"""

# ╔═╡ 60b10931-cdd0-4815-bcf6-21d18e04c7fe
html"<span id='sec42'></span>"

# ╔═╡ 6741a499-ef19-4b60-8901-aef9b20dd0bc
md"""
## 4.2 - Condições de autoexcitação (excitação derivação)

Para que o gerador em derivação se autoexcite é necessário (i) magnetismo remanescente e (ii) $$R_d<R_{crit}$$, sendo $$R_{crit}$$ o declive da zona linear da característica magnética (a 1500 rpm), que pode ser aproximado pelo primeiro par de valores não nulos da característica. A resistência crítica fixa o valor máximo da resistência do circuito de excitação, $$R_{ex}=R_c+R_d$$, e, por isso, o valor máximo do reóstato de campo[^RLuis_separshunt]. A tensão em vazio é a da intersecção da recta de excitação, $$U=R_{ex}I_d$$, com a característica magnética.

Número de pontos usados na regressão da zona linear (inclui o ponto remanente): $(@bind N_lin Slider(3:9, default=6, show_value=true))
"""

# ╔═╡ c8fe90c6-2515-4725-90bc-862802231b86
html"<span id='sec43'></span>"

# ╔═╡ 4e75afb3-68d0-4d60-aef6-4ddb27938c6c
md"""
**Observação de regulação (folha de cálculo):** $$I$$ = $(I_reg_obs) A, $$U$$ = $(U_reg_obs) V, $$n$$ = $(n_reg_obs) rpm ($$f$$ = $(f_reg_obs) Hz no variador). Com $$E_0\propto n$$ e $$R_{eq}$$ da regressão, estima-se para essa velocidade e corrente:
"""

# ╔═╡ 06c56f64-34a3-40d2-88d6-03ef31bfd844
html"<span id='sec44'></span>"

# ╔═╡ 4f2a3a8e-7012-4359-9b05-6b13b045540f
html"<span id='sec45'></span>"

# ╔═╡ a248aed1-b0b0-416d-93df-45831e692b7a
md"""
As tensões em vazio diferem entre ensaios ($U_0$ ≈ 200 a 212 V). Para comparar a *forma* das curvas, representa-se $U/U_0$:
"""

# ╔═╡ bd2479e8-c8b6-42fc-a100-77035bad3f8e
html"<span id='sec46'></span>"

# ╔═╡ ec9f4678-7624-463d-97b5-c588d4ffab66
md"""
## 4.6 - Regulação de tensão

A regulação de tensão define-se por $$\varepsilon\,[\%]=\dfrac{U_0-U}{U}\times 100$$, com $$U$$ a tensão para a corrente $$I_{eval}$$ (interpolada). Corrente de comparação, $$I_{eval}$$ (A): $(@bind I_eval NumberField(1.0:0.5:22.0, default=20.0))
"""

# ╔═╡ 4aed194d-ece6-4ce8-b2ea-552af91cb6e6
md"""
Exemplo de cálculo (composta aditiva):
"""

# ╔═╡ 6dce2eb9-b96b-4fef-b213-1e5737b7b4a7
html"<span id='sec47'></span>"

# ╔═╡ 70ddc2a0-047c-4f32-bb17-feaadf7df41e
html"<span id='sec5'></span>"

# ╔═╡ 425dd22b-3872-45ec-a4f2-e2ba8d6d1eeb
md"""
# 5 - Conclusões

Neste trabalho laboratorial foram estudados experimentalmente diferentes tipos de geradores de corrente contínua (excitação separada, derivação e composta, aditiva e subtractiva). Os ensaios permitiram obter as curvas características fundamentais para compreender as suas diferenças de funcionamento.

Da análise dos resultados, destacam-se as seguintes conclusões fundamentais em resposta aos objectivos propostos:

- **Características magnética e de fluxo:** Validou-se a proporcionalidade directa entre a força electromotriz e a velocidade de rotação. O ensaio em vazio confirmou a presença imprescindível do magnetismo remanescente, base para o escorvamento das máquinas autoexcitadas.
- **Condições de autoexcitação:** No gerador em derivação, comprovou-se na prática o cumprimento das condições teóricas para a autoexcitação: a existência de fluxo remanescente e a garantia de que a resistência do circuito indutor era estritamente inferior à resistência crítica da máquina à velocidade de ensaio.
- **Quedas de tensão:** A separação das quedas de tensão no ensaio de excitação separada demonstrou que o decréscimo da tensão aos terminais não advém apenas das perdas óhmicas ($R_i \cdot I$). A reacção magnética do induzido e a queda nas escovas assumem um papel preponderante e desmagnetizante à medida que a carga aumenta.
- **Comparação das excitações:** A sobreposição das características externas explicitou as diferenças de regulação. O gerador em derivação sofre a quebra de tensão mais acentuada entre os modos simples, devido à dependência do seu circuito indutor face à tensão de saída. A excitação composta aditiva mostrou ser a mais estável (regime hipo-composto), com o enrolamento série a compensar de forma eficaz as perdas internas. Pelo contrário, a composta subtractiva apresentou o colapso de tensão esperado devido à oposição de fluxos.
- **Limitações dos ensaios:** As ligeiras discrepâncias observadas entre as curvas teóricas construídas e as medições reais podem ser justificadas pelo aquecimento progressivo dos enrolamentos ao longo da sessão (que eleva as resistências face aos valores medidos a frio) e por eventuais flutuações residuais na velocidade de arrasto.

Em suma, os objectivos do trabalho foram integralmente cumpridos. A execução dos diferentes esquemas eléctricos e a condução dos ensaios permitiram consolidar, de forma prática e evidente, os princípios teóricos de regulação e o comportamento sob carga das máquinas de corrente contínua.

"""

# ╔═╡ b857b5e2-176b-4faf-984b-e40f533e8d81
md"""
# Declaração de uso de GenAI

Recorreu-se a GenAI para a estrutura do notebook e para o código de tratamento dos dados. A interpretação dos resultados, a análise crítica e as conclusões são da responsabilidade dos autores.

Os autores declaram que, na elaboração deste trabalho, foram utilizadas as seguintes ferramentas de inteligência artificial:

- **Perplexity AI Pro:** utilizada para pesquisa de fontes e referências bibliográficas relevantes ao tema de estudo;
- **Claude (Anthropic):** utilizada para revisão e refinamento do texto, visando maior fluidez na redacção e correcção linguística;
- **Writefull:** utilizado como ferramenta de correcção ortográfica e melhor clareza linguística;
- **Nano Banana Pro:** empregue na geração de esquemas e imagens.

As ferramentas de inteligência artificial mencionadas foram utilizadas exclusivamente como instrumentos de apoio técnico e metodológico, sem substituir o trabalho intelectual e científico dos autores. Não existindo no Instituto Superior de Engenharia de Lisboa orientações específicas quanto ao uso de inteligência artificial em contexto de trabalhos académicos, foram seguidas as recomendações constantes no *"Guia para a utilização responsável da Inteligência Artificial"* do Instituto Superior Técnico [^IST_IA], garantindo-se, assim, a conformidade com as melhores práticas éticas e metodológicas no uso destas tecnologias em ambiente académico.

Os autores assumem inteira responsabilidade editorial e científica pelo conteúdo apresentado, garantindo que todas as informações, análises, interpretações e conclusões são de sua autoria e responsabilidade. Declara-se ainda que nenhuma outra fonte bibliográfica para além das expressamente citadas neste trabalho foi utilizada, assegurando-se assim a transparência e rigor na apresentação das referências que fundamentam esta pesquisa.
"""

# ╔═╡ 89a9870f-2c6a-46c5-a9dc-5c0bfccf50a9
md"""
# Referências

[^RLuis_notebooks]: R. Luís, *Notebooks Computacionais Aplicados a Máquinas Eléctricas II*. Disponível em: <https://ricardo-luis.github.io/me-2/>.

[^RLuis_enunciados]: R. Luís, *Enunciados dos Trabalhos Laboratoriais — Máquinas Eléctricas II*, ISEL, 2026.

[^RLuis_separshunt]: R. Luís, «Gerador de excitação separada (ou independente) e Gerador de excitação em derivação (ou gerador shunt)», *Notebooks Computacionais Aplicados a Máquinas Eléctricas II*. ISEL, Lisboa, Portugal, 2025. [Online]. Disponível em: <https://ricardo-luis.github.io/me-2/Separ.Shunt.GEN.html>

[^RLuis_compound]: R. Luís, «Gerador de excitação composta (ou gerador compound)», *Notebooks Computacionais Aplicados a Máquinas Eléctricas II*. ISEL, Lisboa, Portugal, 2025. [Online]. Disponível em: <https://ricardo-luis.github.io/me-2/Compound.GEN.html>

[^Chapman]: S. J. Chapman, *Electric Machinery Fundamentals*, 5.ª ed. New York, NY, USA: McGraw-Hill, 2012.

[^IST_IA]: A. Oliveira, C. Silva, F. Joaquim, P. André, P. Monteiro, P. T. Monteiro e T. Peña, *Utilização da Inteligência Artificial no Instituto Superior Técnico: Reflexão e Guia*, Instituto Superior Técnico, 📌 (ano). Disponível em: <https://tecnico.ulisboa.pt/pt/noticias/campus-e-comunidade/tecnico-apresenta-guia-para-a-utilizacao-responsavel-da-inteligencia-artificial/#reflexao-e-guia-para-a-utilizacao-da-inteligencia-artificial-no-instituto-superior-tecnico-2/1/>
"""

# ╔═╡ 92c0f101-c9fc-497d-92d2-3185d0a3559a
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%;
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%;
	text-align: justify
}
/* centrar os gráficos e os esquemas (imagens que são a própria saída da célula) */
pluto-output > div > img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
"""

# ╔═╡ 3a4e02bc-a411-4a53-9199-85c8d9964f82
md"""
# Notebook
"""

# ╔═╡ b68a154b-48de-4978-b845-806cd245ca5d
md"""
Este relatório segue o formato dos *notebooks* da unidade curricular[^RLuis_notebooks]. Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Handcalcs](https://co1emi11er2.github.io/Handcalcs.jl/stable/), [Plots](https://docs.juliaplots.org/), [DataFrames](https://dataframes.juliadata.org/).
"""

# ╔═╡ 8391b8ab-58f6-4128-8f87-7eeca0fb211e
TableOfContents(title="Índice")

# ╔═╡ 753cdc33-d9a9-43b2-8d5d-61f64c0c6ae5
# ╠═╡ disabled = true
# ╠═╡ skip_as_script = true
#=╠═╡
aside((md"""
!!! info
	No índice deste *notebook*, os tópicos assinalados com "💻" contêm dados editáveis pelo grupo.
"""), v_offset=-170)
  ╠═╡ =#

# ╔═╡ cb0bad2c-aad2-449c-8c30-ae22a87e25f5
md"""
## Configuração

Células de configuração do relatório (pacotes, funções auxiliares, numeração de figuras e tabelas, endereço das imagens e logótipo), com o código oculto.
"""

# ╔═╡ d0b8f53b-10ec-449e-80eb-50bdd46ecb5d
default(size=(720, 420), lw=2, framestyle=:box, legend=:best, markerstrokewidth=0, markersize=2.5);

# ╔═╡ 1851e4aa-d15c-44bf-8052-f1dbc8bee02a
begin
	# Interpolação linear (xs crescente). Devolve NaN fora do intervalo medido.
	function interp_lin(x, xs, ys)
		(x < xs[1] || x > xs[end]) && return NaN
		i = min(searchsortedlast(xs, x), length(xs) - 1)
		return ys[i] + (ys[i+1] - ys[i]) * (x - xs[i]) / (xs[i+1] - xs[i])
	end

	# Regressão linear y = m·x + b, com erros-padrão de m e b e coeficiente R²
	function regressao_linear(x, y)
		n = length(x)
		xm = mean(x)
		ym = mean(y)
		Sxx = sum((x .- xm) .^ 2)
		m = sum((x .- xm) .* (y .- ym)) / Sxx
		b = ym - m * xm
		SSres = sum((y .- (m .* x .+ b)) .^ 2)
		s2 = SSres / (n - 2)
		return (m = m, b = b, σm = sqrt(s2 / Sxx), σb = sqrt(s2 * (1 / n + xm^2 / Sxx)),
			R2 = 1 - SSres / sum((y .- ym) .^ 2))
	end
end;

# ╔═╡ 89ab6e23-489b-41ec-9534-ba1fce61c240
begin
	E0_sep   = regressao_linear(I_c11, U_c11).b          # V, E₀ extrapolado para I = 0 (não há ponto em vazio nesta tabela)
	ΔUT_sep  = E0_sep .- U_c11                           # queda de tensão total
	ΔUr_sep  = Ri_11 .* I_c11                            # queda na resistência do induzido
	ΔUo_sep  = ΔUT_sep .- ΔUr_sep                        # RMI + escovas (não separáveis só com este ensaio)
	DataFrame("Carga [%]" => carga_11, "I [A]" => I_c11, "U [V]" => U_c11,
		"ΔU_T [V]" => round.(ΔUT_sep, digits=2), "ΔU_r [V]" => round.(ΔUr_sep, digits=2),
		"ΔU_RMI+esc [V]" => round.(ΔUo_sep, digits=2),
		"P = U·I [W]" => round.(U_c11 .* I_c11, digits=0), "R_carga = U/I [Ω]" => round.(U_c11 ./ I_c11, digits=1))
end

# ╔═╡ dcacb1a2-6a5d-40d1-b650-5416f478873d
begin
	Ii_der    = I_der .+ Id_der                    # corrente no induzido
	E0cal_der = U_der .+ Ri_12 .* Ii_der           # E = U + Ri·Ii
	E0mag_der = [interp_lin(i, Iexc_c2, E0_c2) for i in Id_der]    # E₀ na característica magnética (1500 rpm) para o Id medido
	DataFrame("Carga [%]" => carga_der, "I [A]" => I_der, "I_d [A]" => Id_der, "I_i = I+I_d [A]" => round.(Ii_der, digits=3),
		"U [V]" => U_der, "ΔU_T = U₀−U [V]" => U_der[1] .- U_der, "ΔU_r = Ri·Ii [V]" => round.(Ri_12 .* Ii_der, digits=2),
		"U+Ri·Ii [V]" => round.(E0cal_der, digits=1), "E₀(I_d) [V]" => round.(E0mag_der, digits=1))
end

# ╔═╡ 5c8af6f1-e296-4360-aaad-4496b224ed50
begin
	E0_1500_interp = [interp_lin(i, Iexc_c2, E0_c2) for i in Iexc_c1]
	DataFrame("I_exc [A]" => Iexc_c1, "E₀ @ $(n_vz1) rpm [V]" => E0_c1,
		"E₀ @ $(n_vz2) rpm (interp.) [V]" => round.(E0_1500_interp, digits=1),
		"razão E₀(1500)/E₀(750)" => round.(E0_1500_interp ./ E0_c1, digits=2))
end

# ╔═╡ 2adb39ad-36aa-47cb-9a3e-5431681a6957
begin
	ajuste_mag = regressao_linear(Iexc_c2[1:N_lin], E0_c2[1:N_lin])
	Rcrit = ajuste_mag.m
	md"""
	- Magnetismo remanescente a 1500 rpm: $$E_r$$ = $(Er_vz2) V (≠ 0).
	- Regressão linear de $$E_0=f(I_{exc})$$ na zona linear: $$m=R_{crit}$$ = **$(round(Rcrit, digits=1)) ± $(round(ajuste_mag.σm, digits=1)) Ω**, $$b$$ = $(round(ajuste_mag.b, digits=2)) ± $(round(ajuste_mag.σb, digits=2)) V, $$R^2$$ = $(round(ajuste_mag.R2, digits=4)).
	- Aproximação pelo primeiro par de valores não nulos: $$R_{crit}\approx E_0/I_{exc}$$ = **$(round(E0_c2[2] / Iexc_c2[2], digits=1)) Ω** (sem descontar o remanescente) ou **$(round((E0_c2[2] - Er_vz2) / Iexc_c2[2], digits=1)) Ω** (descontando-o).
	- Resistência do circuito indutor em derivação (TL1.2): $$R_d$$ = $(Rd_12) Ω $(Rd_12 < Rcrit ? "<" : "≥") $$R_{crit}$$.
	- Resistência do circuito de excitação medida em vazio, $$R_{ex}=U_0/I_d$$ = **$(round(U_der[1] / Id_der[1], digits=1)) Ω**, valor próximo de $$R_d$$ ($(Rd_12) Ω, terminais J-K).
	"""
end

# ╔═╡ 50de31ac-e707-403c-960c-6121035b49f9
begin
	# Numeração automática de figuras e tabelas (equivalente a \label / \ref do LaTeX).
	# A POSIÇÃO na lista define o número: para reordenar, basta mudar a ordem da lista.
	lista_figuras = [:fig_esq_sep, :fig_esq_der, :fig_esq_add, :fig_esq_sub,
		:fig_magnetica, :fig_fluxo, :fig_sep, :fig_der, :fig_add, :fig_sub,
		:fig_escala, :fig_autoexc, :fig_quedas, :fig_derE, :fig_der_teo, :fig_comp, :fig_norm, :fig_pot, :fig_reg_quedas, :fig_reg]
	lista_tabelas = [:tab_material, :tab_resist, :tab_vazio1, :tab_vazio2, :tab_sep, :tab_der,
		:tab_add, :tab_sub, :tab_prop, :tab_eps]

	num_fig(id) = findfirst(==(id), lista_figuras)
	num_tab(id) = findfirst(==(id), lista_tabelas)

	# Legenda: etiqueta com âncora (id), para poder ser ligada a partir do texto.
	# Uso (início do parágrafo, em negrito):  **$(leg_fig(:fig_magnetica))** Texto da legenda.
	# O scroll-margin-top desloca o ponto de chegada da ligação para baixo, de modo a que a figura/tabela
	# (que está por cima da legenda) fique visível. Ajustar os valores (px) se necessário.
	leg_fig(id) = HTML("<span id='$(id)' style='display:inline-block; scroll-margin-top:480px'>Figura $(num_fig(id)):</span>")
	leg_tab(id) = HTML("<span id='$(id)' style='display:inline-block; scroll-margin-top:650px'>Tabela $(num_tab(id)):</span>")

	# Referência no texto: ligação clicável para a legenda.   $(ref_fig(:fig_magnetica))  →  "Figura 5"
	ref_fig(id) = HTML("<a href='#$(id)'>Figura $(num_fig(id))</a>")
	ref_tab(id) = HTML("<a href='#$(id)'>Tabela $(num_tab(id))</a>")
end;

# ╔═╡ 6dde47e1-033f-4384-a841-cc9ac52b4a7d
md"""
## 2.1 - Esquema(s) de ligações

Para o primeiro conjunto de ensaios (TL1.1) foi montado o gerador de excitação separada (ou independente), $(ref_fig(:fig_esq_sep)).
"""

# ╔═╡ 0ff205db-0f7c-4072-81cd-5072997b356b
md"""
**$(leg_fig(:fig_esq_sep))** Circuito para gerador de excitação separada.
"""

# ╔═╡ c74a26e7-4fcd-40f7-985f-0bf22c25de3b
md"""
Para o segundo conjunto de ensaios (TL1.2) foi montado o gerador em excitação derivação (*shunt*), $(ref_fig(:fig_esq_der)).
"""

# ╔═╡ ac256418-9873-4056-9c8b-92948905e9c8
md"""
**$(leg_fig(:fig_esq_der))** Circuito para gerador de excitação derivação (*shunt*).
"""

# ╔═╡ c6d9e9a7-cdc1-4e36-9122-627e7e23366b
md"""
Foi montado também como gerador de excitação composta (*compound*), em longa derivação e com fluxo aditivo, $(ref_fig(:fig_esq_add)).
"""

# ╔═╡ de9d3a68-a218-4ef2-953b-743952fd50e6
md"""
**$(leg_fig(:fig_esq_add))** Circuito para gerador de excitação composta (*compound*), longa derivação, fluxo aditivo.
"""

# ╔═╡ 1c6e4b5b-ae4a-4681-9018-e98de0892b24
md"""
Por último foi montado como gerador de excitação composta (*compound*), em longa derivação e com fluxo subtractivo, $(ref_fig(:fig_esq_sub)).
"""

# ╔═╡ d75e4270-86b1-4efc-a9b9-f6916c98a70b
md"""
**$(leg_fig(:fig_esq_sub))** Circuito para gerador de excitação composta (*compound*), longa derivação, fluxo subtractivo.
"""

# ╔═╡ cc5c9add-b887-435a-9a3f-260a456b37b6
md"""
!!! warning "Verificar antes de entregar"
	📌 Os esquemas indicam o indutor como C-D, enquanto as resistências medidas na máquina ensaiada estão registadas como J-K ($(ref_tab(:tab_resist))). Confirmar a designação dos terminais e indicar a fonte dos esquemas (se adaptados de outra obra, citar).
"""

# ╔═╡ d855d53d-efd8-42df-8f81-bb0f7a8b35fd
md"""
## 2.2 - Material utilizado

Na $(ref_tab(:tab_material)) indica-se o equipamento utilizado nos ensaios. 📌 Completar o fabricante/modelo e as características dos equipamentos assinalados.

| Equipamento | Fabricante/modelo | Características principais |
|:--|:--|:--|
| Gerador CC (máquina em ensaio) | Elektromotoren Werke Kaiser | 📌 |
| Motor CC (accionamento do gerador) | Elektromotoren Werke Kaiser | 📌 |
| Variador de velocidade | - | - |
| Fonte de alimentação CC | Laboratório M.E. | [-110, 0, +110] V |
| Reóstato de campo | - | [0–750] Ω |
| Reóstato de carga (caixa de cargas resistivas) | - | - |
| Interruptor fusível | 📌25A? | 📌32A? |
| 2 pinças amperimétricas | - | - |
| Multímetro digital (função voltímetro) | 📌 | 📌 |
| Ohmímetro digital | - | - |
| Tacómetro digital | - | - |
| Cabos de ligação | - | - |
"""

# ╔═╡ c84e6d57-4c72-4fea-8f17-8892124af01b
md"""
**$(leg_tab(:tab_material))** Material utilizado.
"""

# ╔═╡ e37a8e7d-a9b7-44a1-9a19-6edeec501535
md"""
## 2.3 - Condução do trabalho

Descrevem-se, para cada ensaio, os passos seguidos: o ensaio em vazio e o ensaio em carga do gerador de excitação separada (TL1.1) e os ensaios em carga do gerador autoexcitado, em excitação derivação e em excitação composta (TL1.2).

(📌 Confirmar os valores e instrumentos indicados à sessão efectivamente realizada.)

### 2.3.1 - TL1.1: excitação separada em vazio

1. Montou-se o circuito da $(ref_fig(:fig_esq_sep)), sem ligar a carga (interruptor de carga aberto);
1. Verificaram-se os alcances e a calibração dos aparelhos de medida;
1. O motor de arrasto foi accionado até estabilizar numa velocidade constante, $$n_1=750$$ rpm (📌 indicar o instrumento de medida da velocidade);
1. Variou-se a corrente de excitação, $$I_{exc}$$, ajustando o reóstato de campo, em passos incrementais. Para cada passo, registou-se $$I_{exc}$$ e a tensão gerada no induzido, $$E_0$$ (incluindo o valor remanescente, com $$I_{exc}=0$$);
1. Repetiu-se o procedimento para uma segunda velocidade constante, $$n_2=1500$$ rpm.

### 2.3.2 - TL1.1: excitação separada em carga

1. Mantendo a montagem da $(ref_fig(:fig_esq_sep)), ajustou-se a velocidade para $$n=1500$$ rpm e a corrente de excitação para um valor que produzisse a tensão em vazio pretendida (📌 indicar $$E_0$$ e $$I_{exc}$$), mantendo-a constante;
1. Ligou-se a carga e variou-se a sua resistência para aumentar gradualmente a corrente de carga, $$I$$. Para cada passo, registou-se o par de valores ($$I$$, $$U$$);
1. Com a máquina desligada, registaram-se as resistências dos enrolamentos;
1. Regulação de um ponto de funcionamento em carga (📌 descrever a manobra efectuada).

### 2.3.3 - TL1.2: excitação derivação

1. Modificou-se a montagem para o esquema da $(ref_fig(:fig_esq_der));
1. O motor de arrasto foi accionado até estabilizar numa velocidade constante, $$n=1500$$ rpm, e ajustou-se o reóstato de campo para a tensão em vazio pretendida (📌 indicar $$U_0$$), sem o reajustar durante o ensaio;
1. Ligou-se a carga e variou-se a sua resistência para aumentar gradualmente a corrente de carga, $$I$$. Para cada passo, registaram-se $$I$$, $$I_d$$ e $$U$$.

### 2.3.4 - TL1.2: excitação composta aditiva e subtractiva

1. Alterou-se a montagem para a da $(ref_fig(:fig_esq_add)), inserindo o enrolamento de excitação série (E-F), com fluxo aditivo;
1. Repetiu-se o procedimento do ensaio anterior, registando os valores à medida que a carga era aumentada;
1. Alterou-se a montagem para a da $(ref_fig(:fig_esq_sub)), invertendo a polaridade do enrolamento de excitação série (fluxo subtractivo), e repetiu-se o procedimento.
"""

# ╔═╡ e6b6aae2-340a-4ef5-936a-743e23c49881
md"""
Nesta secção apresentam-se as tabelas com os valores medidos e os gráficos resultantes dos ensaios (primeiro os valores de cada ensaio e, seguidamente, as curvas características dos geradores), sem interpretação nesta fase.

## 3.1 - 💻 Resistências dos enrolamentos e chapa de características

Registam-se na $(ref_tab(:tab_resist)) as resistências dos enrolamentos, medidas com a máquina desligada em cada uma das sessões (TL1.1 e TL1.2).
"""

# ╔═╡ 686d37f2-c05d-4266-8c23-d2b0b12bd19f
md"""
**$(leg_tab(:tab_resist))** Resistências dos enrolamentos. 📌 *Inserir a chapa de características do gerador (figura em anexo).*
"""

# ╔═╡ 33981584-9369-47b6-a7a2-c0e18e64758f
md"""
## 3.2 - TL1.1: excitação separada em vazio

O ensaio em vazio do gerador de excitação separada (TL1.1) foi realizado a duas velocidades constantes, 750 rpm e 1500 rpm. Para cada velocidade, variou-se a corrente de excitação, $$I_{exc}$$, e registou-se a f.e.m. induzida, $$E_0$$.

### 3.2.1 - 💻 Dados experimentais

Os valores registados a cada velocidade, incluindo o magnetismo remanescente ($$I_{exc}=0$$) e a razão $$k\varphi=E_0/n$$, apresentam-se na $(ref_tab(:tab_vazio1)) (750 rpm) e na $(ref_tab(:tab_vazio2)) (1500 rpm).
"""

# ╔═╡ d2a36534-325d-476e-9069-06bbb86bd2ca
md"""
**$(leg_tab(:tab_vazio1))** Ensaio em vazio, excitação separada, $$n_1$$ = 750 rpm (remanescente: 3,14 V).
"""

# ╔═╡ dfe04e63-3704-448a-a294-253d18386f09
md"""
**$(leg_tab(:tab_vazio2))** Ensaio em vazio, excitação separada, $$n_2$$ = 1500 rpm (remanescente: 6,27 V).
"""

# ╔═╡ d3d9824c-d7df-48ec-abae-2acb5430212b
md"""
### 3.2.2 - Características magnéticas

Com os valores anteriores traçaram-se a característica magnética, na $(ref_fig(:fig_magnetica)), e a característica de fluxo, na $(ref_fig(:fig_fluxo)).
"""

# ╔═╡ 5abcf517-b77b-48b5-aea2-a8e7b98745e5
md"""
**$(leg_fig(:fig_magnetica))** Característica magnética, $$E_0=f(I_{exc})$$, às duas velocidades (apenas os pontos medidos).
"""

# ╔═╡ caa22c20-066e-45da-b33f-1a3ab568f6b7
md"""
**$(leg_fig(:fig_fluxo))** Característica de fluxo, $$k\varphi=E_0/n=f(I_{exc})$$.
"""

# ╔═╡ c2d747a3-d376-4e3f-9266-8d3e7bc79a18
md"""
## 3.3 - TL1.1: excitação separada em carga

No ensaio em carga do gerador de excitação separada (TL1.1), à velocidade de 1500 rpm e com $$I_{exc}$$ constante, aumentou-se gradualmente a carga, registando a corrente de carga, $$I$$, e a tensão aos terminais, $$U$$.

### 3.3.1 - 💻 Dados experimentais

Os valores registados (de 15 % a 165 % de carga) apresentam-se na $(ref_tab(:tab_sep)), com as quedas de tensão e a potência de saída calculadas, e a característica externa na $(ref_fig(:fig_sep)).
"""

# ╔═╡ 278c84fd-b6b6-457e-9227-8b5b4eba9c10
md"""
!!! warning "Verificar antes de entregar"
	Na folha, $$I_{exc}$$ em carga está registada como **0,206 A**, que coincide com o último ponto do ensaio em vazio a 1500 rpm ($$E_0$$ = 91 V). Com $$I_{exc}$$ = 0,206 A não se obteria $$U$$ ≈ 206 V à velocidade de 1500 rpm (seriam necessários ≈ 0,65 A, ver $(ref_tab(:tab_vazio2))). 📌 Confirmar o valor de $$I_{exc}$$ efectivamente mantido durante o ensaio.
"""

# ╔═╡ c25f7278-b8bc-41a5-9ba6-04e49aacb393
md"""
**$(leg_tab(:tab_sep))** Ensaio em carga, excitação separada ($$n$$ = 1500 rpm, $$I_{exc}$$ constante). $$E_0$$ obtido por extrapolação linear de $$U=f(I)$$ (secção 4.3); $$\Delta U_T=E_0-U$$; $$\Delta U_r=R_i\,I$$.
"""

# ╔═╡ c1daf204-959d-4749-a6d4-a0c1e42eb44b
md"""
**$(leg_fig(:fig_sep))** Característica externa do gerador de excitação separada, $$U=f(I)$$, com regressão linear.
"""

# ╔═╡ 0f12f102-f0f7-4205-8fd3-3c1905df13b4
md"""
## 3.4 - TL1.2: excitação derivação

No ensaio em carga do gerador em excitação derivação (TL1.2), à velocidade de 1500 rpm e sem reajustar o reóstato de campo, registaram-se $$I$$, $$I_d$$ e $$U$$. Os valores apresentam-se na $(ref_tab(:tab_der)) e a característica externa na $(ref_fig(:fig_der)).

### 💻 Dados experimentais

Os valores registados no ensaio, editáveis na célula seguinte, alimentam a tabela e o gráfico seguintes.
"""

# ╔═╡ 36fb4e06-e5a6-403d-b656-944e181347d7
md"""
**$(leg_tab(:tab_der))** Ensaio em carga, excitação derivação ($$n$$ = 1500 rpm). $$E_0(I_d)$$: valor da característica magnética a 1500 rpm ($(ref_tab(:tab_vazio2))) para a corrente de excitação medida.
"""

# ╔═╡ 222ff8c3-0305-4b8c-a5db-e5a73456ea46
md"""
**$(leg_fig(:fig_der))** Característica externa do gerador em excitação derivação.
"""

# ╔═╡ d5670b0c-d3b2-49c1-b74b-98a8efe719e5
md"""
## 3.5 - TL1.2: excitação composta aditiva

No ensaio em carga do gerador em excitação composta aditiva (TL1.2), o enrolamento série (E-F) foi ligado de modo a reforçar o fluxo do enrolamento em derivação. Os valores registados apresentam-se na $(ref_tab(:tab_add)) e a característica externa na $(ref_fig(:fig_add)).

### 💻 Dados experimentais

Os valores registados no ensaio, editáveis na célula seguinte, alimentam a tabela e o gráfico seguintes.
"""

# ╔═╡ 96375eab-8202-412b-8ec8-5220300b2c6e
md"""
!!! warning "Verificar antes de entregar"
	Os valores da coluna $$I_d$$ da excitação composta aditiva (0,003 a 0,088 A) não são compatíveis com a corrente de excitação em derivação para $$U$$ ≈ 200 V (da ordem de 0,5 a 0,6 A, como na $(ref_tab(:tab_der)) e na $(ref_tab(:tab_sub))). Possível erro de leitura ou de alcance. Esta coluna **não é usada** nos cálculos. 📌 Confirmar ou corrigir.
"""

# ╔═╡ 3035d419-e193-46f2-a8cc-992651ac08b3
md"""
**$(leg_tab(:tab_add))** Ensaio em carga, excitação composta aditiva ($$n$$ = 1500 rpm).
"""

# ╔═╡ 3ca00a5d-10b8-43c4-82ba-2b5a806760a3
md"""
**$(leg_fig(:fig_add))** Característica externa do gerador em excitação composta aditiva.
"""

# ╔═╡ 7344644a-61d5-4dbe-9937-67ab96e75077
md"""
## 3.6 - TL1.2: excitação composta subtractiva

No ensaio em carga do gerador em excitação composta subtractiva (TL1.2), o enrolamento série foi ligado com a polaridade invertida, de modo a opor-se ao fluxo do enrolamento em derivação. Os valores registados apresentam-se na $(ref_tab(:tab_sub)) e a característica externa na $(ref_fig(:fig_sub)).

### 💻 Dados experimentais

Os valores registados no ensaio, editáveis na célula seguinte, alimentam a tabela e o gráfico seguintes.
"""

# ╔═╡ 2e657109-261e-4091-97ba-9d093475a1cc
md"""
**$(leg_tab(:tab_sub))** Ensaio em carga, excitação composta subtractiva ($$n$$ = 1500 rpm).
"""

# ╔═╡ 5b93746a-8b49-4091-8b19-dd546cca1194
md"""
**$(leg_fig(:fig_sub))** Característica externa do gerador em excitação composta subtractiva.
"""

# ╔═╡ 41435062-7fe4-485d-ab8a-d7e4fd380d62
md"""
**$(leg_tab(:tab_prop))** Razão entre as f.e.m. em vazio às duas velocidades, para o mesmo $$I_{exc}$$ (razão das velocidades: $$n_2/n_1$$ = 2,00). 📌 Discutir.
"""

# ╔═╡ e95407b9-08c4-4687-aa0d-b6c82b25b499
md"""
**$(leg_fig(:fig_escala))** Característica magnética a 1500 rpm medida e obtida a partir da característica a 750 rpm, $$E_0(n)=\frac{n}{n_{mag}}E_0(n_{mag})$$. 📌 Discutir.
"""

# ╔═╡ 60c28e92-fb65-4a29-9e74-9cf1af6a8aea
begin
	# Ponto de funcionamento em vazio: maior raiz de E₀(Id) − Rd·Id = 0
	Id_grelha = range(0.0, maximum(Iexc_c2), length=2001)
	g_vazio = [interp_lin(i, Iexc_c2, E0_c2) - Rd_12 * i for i in Id_grelha]
	k_raiz = findlast(k -> g_vazio[k] >= 0 && g_vazio[k+1] < 0, 1:length(g_vazio)-1)
	Id0_prev = Id_grelha[k_raiz] + step(Id_grelha) * g_vazio[k_raiz] / (g_vazio[k_raiz] - g_vazio[k_raiz+1])
	U0_prev = Rd_12 * Id0_prev
	md"""
	Ponto de funcionamento em vazio previsto (intersecção da recta $$U=R_d I_d$$ com a característica magnética): $$I_d$$ ≈ $(round(Id0_prev, digits=3)) A e $$U_0$$ ≈ $(round(U0_prev, digits=1)) V, face aos $(U_der[1]) V e $(Id_der[1]) A medidos em vazio na $(ref_tab(:tab_der)).
	"""
end

# ╔═╡ cdacb1e0-486f-466f-90d6-9e3267cd2fc8
md"""
**$(leg_fig(:fig_autoexc))** Característica magnética a 1500 rpm, recta do circuito indutor em derivação e recta de $$R_{crit}$$. 📌 Discutir as condições de autoexcitação.
"""

# ╔═╡ 309e6d46-9af8-4851-88b8-39cbad2a1c2f
md"""
## 4.3 - Quedas de tensão: excitação separada

Com $$I_{exc}$$ constante, $$U=E_0-(\Delta U_r+\Delta U_{esc}+\Delta E)$$, sendo $$\Delta U_r=R_i I$$, $$\Delta U_{esc}$$ a queda nas escovas e $$\Delta E$$ a redução de f.e.m. por reacção magnética do induzido (RMI). Como a $(ref_tab(:tab_sep)) não inclui ponto em vazio, $$E_0$$ foi estimado por regressão linear de $$U=f(I)$$:
"""

# ╔═╡ 5555543c-a8b3-4349-b00e-55302c0a3e7b
md"""
**$(leg_fig(:fig_quedas))** Característica externa, $$U=f(I)$$, e quedas de tensão: total ($$\Delta U_T=E_0-U$$), na resistência do induzido ($$\Delta U_r=R_i\,I$$) e restante ($$\Delta E$$, RMI e escovas), em função de $$I$$. $$E_0$$ (extrapolado) a tracejado. 📌 Discutir o peso da RMI no gerador ensaiado.
"""

# ╔═╡ 6e651654-608e-4142-b24d-de9d4741f49c
md"""
## 4.4 - Quedas de tensão: excitação derivação

Em derivação, além de $$\Delta U_r=R_i I_i$$ (com $$I_i=I+I_d$$), o aumento de carga reduz $$U$$ e, por isso, $$I_d$$ e o fluxo. A f.e.m. efectiva, $$U+R_iI_i$$, pode comparar-se com $$E_0(I_d)$$ da característica magnética para o $$I_d$$ medido ($(ref_tab(:tab_der))):
"""

# ╔═╡ c50754c1-9322-4a94-b0cb-a5144067930e
md"""
**$(leg_fig(:fig_derE))** f.e.m. efectiva $$U+R_iI_i$$ e $$E_0(I_d)$$ obtido da característica magnética, em função de $$I$$. 📌 Discutir as diferenças (entre sessões/bancadas, aparelhos de medida, temperatura dos enrolamentos, RMI).
"""

# ╔═╡ 6205f92a-d010-4b73-95b1-f5b9b32d8481
md"""
### 4.4.1 - 💻 Construção da característica externa em derivação a partir da excitação separada

Para a mesma corrente no induzido, a queda de tensão total, $$\Delta U_T$$, é a mesma nos dois modos de excitação (depende apenas da corrente; aqui despreza-se $$I_d$$ face a $$I$$). Assim, pode construir-se $$U=f(I)$$ do gerador em derivação a partir de $$\Delta U_T=f(I)$$, obtida na excitação separada ($(ref_tab(:tab_sep))), e da característica magnética[^RLuis_separshunt]:

1. para cada $$I_d$$, $$U=R_{ex}I_d$$ e $$\Delta U_T=E_0(I_d)-R_{ex}I_d$$, com $$E_0(I_d)$$ da característica magnética a 1500 rpm;
1. a corrente de carga, $$I$$, é a que, na excitação separada, corresponde a esse $$\Delta U_T$$.

Resistência do circuito de excitação, $$R_{ex}$$ (Ω): $(@bind Rexc_t Slider(250:1:390, default=clamp(round(Int, Rd_12), 250, 390), show_value=true))
"""

# ╔═╡ a22914bd-97fc-4886-afe0-ce8850f51f60
md"""
**$(leg_fig(:fig_der_teo))** Característica externa do gerador em derivação: medida e construída a partir de $$\Delta U_T=f(I)$$ (excitação separada) e da característica magnética. 📌 Discutir as diferenças.
"""

# ╔═╡ 5019d9f5-71c5-47bc-8286-9e02309b81eb
md"""
## 4.5 - Comparação das características externas

Comportamento teórico esperado: em excitação separada, a queda de tensão resulta da resistência do induzido e da reacção magnética do induzido (na ausência de enrolamentos de compensação), uma vez que a excitação é independente da carga. Nos geradores autoexcitados, o aumento de carga reduz a tensão aos terminais e, com ela, a corrente de excitação e o fluxo: $$I\uparrow\Rightarrow\Delta U_T\uparrow\Rightarrow I_d\downarrow\Rightarrow U\downarrow$$, pelo que a curva é mais acentuada. Na excitação composta, o enrolamento série, percorrido pela corrente de carga, reforça o fluxo se a ligação for aditiva (compensando a queda de tensão) e enfraquece-o se for subtractiva. 📌 Comparar com as curvas obtidas ($(ref_fig(:fig_comp))) e discutir.
"""

# ╔═╡ c0a70779-3e57-4b9f-a2df-70502de2b9c7
md"""
**$(leg_fig(:fig_comp))** Comparação das características externas, $$U=f(I)$$.
"""

# ╔═╡ 8231daaa-9f48-401b-abe1-550d9b4a8238
md"""
**$(leg_fig(:fig_norm))** Características externas normalizadas, $$U/U_0$$ ($$U_0$$ = tensão em vazio medida; na separada, $$E_0$$ extrapolado). 📌 Discutir.
"""

# ╔═╡ 1f883f87-d5fe-4e85-934f-48adce06f567
md"""
**$(leg_fig(:fig_pot))** Potência eléctrica fornecida à carga, $$P=U\,I$$, em função de $$I$$.
"""

# ╔═╡ 77a8fc85-cdbc-4f9d-9aed-13451c3182bd
md"""
**$(leg_tab(:tab_eps))** Regulação de tensão para $$I$$ = $(I_eval) A. A corrente nominal indicada na folha é $$I_N$$ = $(In_ch) A, superior à máxima ensaiada nas excitações composta e derivação (≈ $(round(maximum([maximum(I_der), maximum(I_add), maximum(I_sub)]), digits=1)) A; subtractiva: $(maximum(I_sub)) A), pelo que se compara para uma corrente comum a todos os ensaios. 📌 Discutir (excitação composta: $$\varepsilon>0$$ hipo-composta, $$\varepsilon\approx0$$ iso-composta, $$\varepsilon<0$$ hiper-composta).
"""

# ╔═╡ 2de777c0-91e0-405e-b048-221c344f98c4
md"""
## 4.7 - Característica de regulação (calculada)

A característica de regulação, $$I_{exc}=f(I)$$ com $$U$$ e $$n$$ constantes, não foi medida. Com a característica magnética a 1500 rpm e $$R_{eq}$$ da regressão (secção 4.3), estima-se a corrente de excitação necessária para manter $$U$$ constante: $$E_0^{nec}=U+R_{eq}\,I$$ e $$I_{exc}=E_0^{-1}(E_0^{nec})$$. Tensão a manter, $$U$$ (V): $(@bind U_reg_const NumberField(100.0:5.0:200.0, default=180.0))

Hipóteses: $$R_{eq}$$ constante e velocidade constante. Só se obtém valor para $$E_0^{nec}$$ dentro do intervalo medido na característica magnética (até $$E_0$$ = $(maximum(E0_c2)) V); fora desse intervalo não se representa.

A $(ref_fig(:fig_reg_quedas)) mostra, em função de $$I$$, as quedas de tensão do modelo linear e o $$E_0$$ necessário para manter $$U$$ constante, e a $(ref_fig(:fig_reg)) a corrente de excitação correspondente.
"""

# ╔═╡ 4b20021f-9293-4929-b354-b3073355ffea
md"""
**$(leg_fig(:fig_reg_quedas))** Quedas de tensão, $$\Delta U_T=R_{eq}\,I$$, $$\Delta U_r=R_i\,I$$ e $$\Delta E$$ (RMI e escovas), e $$E_0$$ necessário para manter $$U$$ constante ($$E_0^{nec}=U+\Delta U_T$$), em função de $$I$$ (modelo linear da secção 4.3). 📌 Discutir.
"""

# ╔═╡ 2d1768d1-bb1e-4e2e-8b4b-11d796f1379c
md"""
**$(leg_fig(:fig_reg))** Característica de regulação calculada, $$I_{exc}=f(I)$$ (a tracejado, a corrente de excitação em vazio). 📌 Discutir (e comparar com a observação de regulação da secção 4.3, se aplicável).
"""

# ╔═╡ 618489c5-d824-4427-995d-103419c638cc
# Endereço da pasta de imagens no GitHub (repositório público). Alterar só aqui se o endereço mudar,
# por exemplo para "https://github.tiago.pt/ISEL_ME-2/images/" depois de configurado o domínio.
url_imagens = "https://raw.githubusercontent.com/gualdrapa/ISEL_ME-2/main/images/";

# ╔═╡ fe34797b-f3a2-4174-be02-f51443fe1766
HTML("<img src='$(url_imagens)esquema_gerador_excitacao_separada.jpg' alt='Circuito para gerador de excitação separada' style='max-width:100%; width:600px'>")

# ╔═╡ f2f04cd6-a284-4578-a51c-1d5871c42fbd
HTML("<img src='$(url_imagens)esquema_gerador_excitacao_derivacao.jpg' alt='Circuito para gerador de excitação derivação (shunt)' style='max-width:100%; width:600px'>")

# ╔═╡ 0879b867-86d3-4fea-9325-cb9a9378669a
HTML("<img src='$(url_imagens)esquema_gerador_excitacao_composta_aditiva.jpg' alt='Circuito para gerador de excitação composta, longa derivação, fluxo aditivo' style='max-width:100%; width:600px'>")

# ╔═╡ aecc3a01-f0a0-4ec5-98b3-a667c918c21e
HTML("<img src='$(url_imagens)esquema_gerador_excitacao_composta_subtractiva.jpg' alt='Circuito para gerador de excitação composta, longa derivação, fluxo subtractivo' style='max-width:100%; width:600px'>")

# ╔═╡ 29c1ea1f-7316-4d6e-83e1-4863c8e08dac
begin
	# Gráficos: cores fixas da paleta, para a linha, os marcadores e a legenda terem a mesma cor.
	paleta = palette(:default)

	# Série com linha e marcadores (a legenda mostra a linha e o marcador).
	function curva!(p, x, y; k, label, marker=:circle, kw...)
		plot!(p, x, y; color=paleta[k], label=label, marker=marker, kw...)
		return p
	end

	# Pontos medidos (sem linha).
	function pontos!(p, x, y; k, label, kw...)
		scatter!(p, x, y; color=paleta[k], label=label, kw...)
		return p
	end
end;

# ╔═╡ c512dc2c-83fe-41e9-af26-5570c00be70f
let p = plot(xlabel="I_exc (A)", ylabel="E₀ (V)", title="Característica magnética (vazio)", legend=:bottomright,
		xlims=(0, :auto), ylims=(0, :auto))
	# só os pontos medidos (o primeiro elemento é o ponto remanescente, I_exc = 0, que não entra no gráfico)
	curva!(p, Iexc_c2[2:end], E0_c2[2:end]; k=1, label="n = $(n_vz2) rpm", marker=:circle)
	curva!(p, Iexc_c1[2:end], E0_c1[2:end]; k=2, label="n = $(n_vz1) rpm", marker=:square)
	p
end

# ╔═╡ 74650170-e03d-43bd-846f-1bf75e83253a
let p = plot(xlabel="I_exc (A)", ylabel="kφ = E₀/n (V/rpm)", title="Característica de fluxo", legend=:bottomright)
	curva!(p, Iexc_c2, E0_c2 ./ n_vz2; k=1, label="n = $(n_vz2) rpm", marker=:circle)
	curva!(p, Iexc_c1, E0_c1 ./ n_vz1; k=2, label="n = $(n_vz1) rpm", marker=:square)
	p
end

# ╔═╡ e69def99-b256-4130-b9e5-d2b5171a70cd
begin
	ajuste_sep = regressao_linear(I_c11, U_c11)
	I_lin_c11 = range(0, 1.05 * maximum(I_c11), length=50)
	let p = plot(xlabel="I (A)", ylabel="U (V)", title="Característica externa — excitação separada")
		pontos!(p, I_c11, U_c11; k=1, label="medido")
		plot!(p, I_lin_c11, ajuste_sep.m .* I_lin_c11 .+ ajuste_sep.b; color=paleta[2], label="regressão linear", ls=:dash, lw=1.5)
		p
	end
end

# ╔═╡ b5f0f838-351d-4314-9787-b392dc24e643
md"""
- Declive: $$m$$ = **$(round(ajuste_sep.m, digits=3)) ± $(round(ajuste_sep.σm, digits=3)) Ω** (resistência equivalente, $$R_{eq}$$ = $(round(-ajuste_sep.m, digits=3)) Ω, face a $$R_i$$ = $(Ri_11) Ω);
- Ordenada na origem: $$E_0$$ = **$(round(ajuste_sep.b, digits=2)) ± $(round(ajuste_sep.σb, digits=2)) V**;
- Coeficiente de determinação, $$R^2$$ = $(round(ajuste_sep.R2, digits=4)).
"""

# ╔═╡ c04ce852-c270-4f0c-9f26-fc4b91aac934
begin
	U_est_reg = E0_sep * (n_reg_obs / n_c11) - (-ajuste_sep.m) * I_reg_obs
	md"""
	Obtém-se $$U_{est}=E_0\,\dfrac{n}{n_{1500}}-R_{eq}\,I$$ = **$(round(U_est_reg, digits=1)) V**, face a $(U_reg_obs) V observados. 📌 Descrever a manobra efectuada e discutir.
	"""
end

# ╔═╡ 3e5c01b7-2d41-47f1-ab97-d60217b20522
begin
	ajuste_der = regressao_linear(I_der, U_der)
	md"""
	Regressão linear de $$U=f(I)$$ (derivação): $$m$$ = **$(round(ajuste_der.m, digits=3)) ± $(round(ajuste_der.σm, digits=3)) Ω**, $$b$$ = **$(round(ajuste_der.b, digits=2)) ± $(round(ajuste_der.σb, digits=2)) V**, $$R^2$$ = $(round(ajuste_der.R2, digits=4)). Excitação separada: $$m$$ = $(round(ajuste_sep.m, digits=3)) Ω.
	"""
end

# ╔═╡ 33fb0829-c3ae-4757-b1ad-059d0dd8f6fc
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Característica externa — excitação derivação")
	curva!(p, I_der, U_der; k=1, label="U = f(I)")
	p
end

# ╔═╡ 92245908-1b37-4fc2-b664-170b7b48a448
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Característica externa — composta aditiva")
	curva!(p, I_add, U_add; k=1, label="U = f(I)")
	p
end

# ╔═╡ 04507d0e-dbc5-4356-9b80-9b0372873f19
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Característica externa — composta subtractiva")
	curva!(p, I_sub, U_sub; k=1, label="U = f(I)")
	p
end

# ╔═╡ 341e2e52-a9fa-418c-a003-c78c925b95b2
let p = plot(xlabel="I_exc (A)", ylabel="E₀ (V)", title="E₀ medido vs. E₀ obtido por proporcionalidade com n", legend=:bottomright)
	curva!(p, Iexc_c2, E0_c2; k=1, label="medido, n = $(n_vz2) rpm", marker=:circle)
	curva!(p, Iexc_c1, (n_vz2 / n_vz1) .* E0_c1; k=2, label="E₀($(n_vz1) rpm) · $(n_vz2)/$(n_vz1)", marker=:square, ls=:dash)
	p
end

# ╔═╡ 3ce6c57c-0f15-44b9-b18a-d250ceac3f44
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Autoexcitação em derivação", legend=:bottomright)
	curva!(p, Iexc_c2, E0_c2; k=1, label="E₀(I_exc), $(n_vz2) rpm", marker=:circle)
	plot!(p, [0, maximum(Iexc_c2)], [0, Rd_12 * maximum(Iexc_c2)]; color=paleta[2], label="U = R_d·I_d  (R_d = $(Rd_12) Ω)", ls=:dash)
	plot!(p, [0, maximum(Iexc_c2)], [ajuste_mag.b, ajuste_mag.b + Rcrit * maximum(Iexc_c2)]; color=paleta[3], label="R_crit (regressão)", ls=:dot)
	pontos!(p, [Id0_prev], [U0_prev]; k=4, label="ponto de funcionamento previsto", markersize=5)
	p
end

# ╔═╡ 31a4f26b-1a5e-49c0-aea1-0dc27d89da6d
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Quedas de tensão — gerador de excitação separada",
		legend=:right, xlims=(0, :auto), ylims=(0, 220))
	plot!(p, I_c11, U_c11; color=paleta[1], lw=3, label="U = f(I)")
	plot!(p, I_c11, ΔUT_sep; color=:black, lw=3, label="ΔU_T = E₀ − U")
	plot!(p, I_c11, ΔUr_sep; color=paleta[3], lw=2, label="ΔU_r = Ri·I")
	plot!(p, I_c11, ΔUo_sep; color=paleta[4], lw=2, label="ΔE (RMI + escovas)")
	hline!(p, [E0_sep]; color=:red, ls=:dash, lw=1.5, label="E₀, n = $(n_c11) rpm")
	p
end

# ╔═╡ be18c701-5efb-4e6d-af39-30686b851079
let p = plot(xlabel="I (A)", ylabel="E (V)", title="Derivação: f.e.m. efectiva vs. característica magnética")
	curva!(p, I_der, E0cal_der; k=1, label="U + Ri·Ii (medido)", marker=:circle)
	curva!(p, I_der, E0mag_der; k=2, label="E₀(I_d) (carac. magnética, 1500 rpm)", marker=:square)
	p
end

# ╔═╡ 1b1af362-13ac-4b67-ac6a-731223ad01aa
begin
	id_t  = range(0.0, maximum(Iexc_c2), length=1001)                  # A
	E0_t  = [interp_lin(i, Iexc_c2, E0_c2) for i in id_t]              # V, característica magnética (1500 rpm)
	dUT_t = E0_t .- Rexc_t .* id_t                                     # V, ΔU_T(I_d) = E₀(I_d) − R_ex·I_d
	sel_t = dUT_t .>= 0                                                # só valores com sentido físico
	Ud_t  = (Rexc_t .* id_t)[sel_t]                                    # V, U = R_ex·I_d
	# corrente de carga que, na excitação separada, corresponde a cada ΔU_T
	# (abaixo do menor ΔU_T medido usa-se a recta da regressão, ΔU_T = R_eq·I)
	I_t   = [d < minimum(ΔUT_sep) ? d / (-ajuste_sep.m) : interp_lin(d, ΔUT_sep, I_c11) for d in dUT_t[sel_t]]

	let p = plot(xlabel="I (A)", ylabel="U (V)", title="Característica externa — derivação", xlims=(0, 30), ylims=(0, 230), legend=:bottomleft)
		plot!(p, I_t, Ud_t; color=paleta[1], lw=2, label="construção (R_ex = $(Rexc_t) Ω)")
		pontos!(p, I_der, U_der; k=2, label="medido (derivação)")
		plot!(p, I_c11, U_c11; color=paleta[3], ls=:dash, lw=1.5, label="excitação separada (medido)")
		p
	end
end

# ╔═╡ 54721e61-d21d-465f-953e-266c8c8e2d6e
let p = plot(xlabel="I (A)", ylabel="U (V)", title="Características externas (1500 rpm)", legend=:bottomleft)
	curva!(p, I_c11, U_c11; k=1, label="Separada", marker=:circle)
	curva!(p, I_der, U_der; k=2, label="Derivação", marker=:square)
	curva!(p, I_add, U_add; k=3, label="Composta aditiva", marker=:diamond)
	curva!(p, I_sub, U_sub; k=4, label="Composta subtractiva", marker=:utriangle)
	p
end

# ╔═╡ 6be45a6b-ce84-41f4-b1c9-90d8335431fe
begin
	U0_exc = [E0_sep, U_der[1], U_add[1], U_sub[1]]
	let p = plot(xlabel="I (A)", ylabel="U / U₀", title="Características externas normalizadas", legend=:bottomleft)
		curva!(p, I_c11, U_c11 ./ U0_exc[1]; k=1, label="Separada", marker=:circle)
		curva!(p, I_der, U_der ./ U0_exc[2]; k=2, label="Derivação", marker=:square)
		curva!(p, I_add, U_add ./ U0_exc[3]; k=3, label="Composta aditiva", marker=:diamond)
		curva!(p, I_sub, U_sub ./ U0_exc[4]; k=4, label="Composta subtractiva", marker=:utriangle)
		p
	end
end

# ╔═╡ dfbe1f84-782d-41e3-83e1-6aa1c9dd2029
begin
	exc_nomes = ["Separada", "Derivação", "Composta aditiva", "Composta subtractiva"]
	U_Ie = [interp_lin(I_eval, I_c11, U_c11), interp_lin(I_eval, I_der, U_der), interp_lin(I_eval, I_add, U_add), interp_lin(I_eval, I_sub, U_sub)]
	ε_exc = (U0_exc .- U_Ie) ./ U_Ie .* 100
	DataFrame("Excitação" => exc_nomes, "U₀ [V]" => round.(U0_exc, digits=1),
		"U(I = $(I_eval) A) [V]" => round.(U_Ie, digits=1), "ε [%]" => round.(ε_exc, digits=1))
end

# ╔═╡ 50a045a1-a9ff-4675-8fdb-a46b58e924d7
begin
	U_vazio = U0_exc[3]                       # V
	U_carga = round(U_Ie[3], digits=1)        # V
	set_default(fmt = "%.1f")                  # uma casa decimal nos valores do exemplo
end;

# ╔═╡ 93114ffd-0f8e-43b7-bd64-4859346448b1
@handcalcs begin
	ε_ex = (U_vazio - U_carga) / U_carga * 100
end

# ╔═╡ f608f999-81a0-4ef3-aa1f-26bc225761bb
let p = plot(xlabel="I (A)", ylabel="P = U·I (W)", title="Potência eléctrica de saída", legend=:topleft)
	curva!(p, I_c11, U_c11 .* I_c11; k=1, label="Separada", marker=:circle)
	curva!(p, I_der, U_der .* I_der; k=2, label="Derivação", marker=:square)
	curva!(p, I_add, U_add .* I_add; k=3, label="Composta aditiva", marker=:diamond)
	curva!(p, I_sub, U_sub .* I_sub; k=4, label="Composta subtractiva", marker=:utriangle)
	p
end

# ╔═╡ 5f9bf960-ee0a-4aa1-bbae-2c69e923c745
begin
	I_reg_grelha = collect(0.0:2.0:28.0)
	E0_nec = U_reg_const .+ (-ajuste_sep.m) .* I_reg_grelha
	Iexc_nec = [interp_lin(e, E0_c2, Iexc_c2) for e in E0_nec]
	let p = plot(xlabel="I (A)", ylabel="I_exc (A)", title="Característica de regulação (calculada)", legend=:topleft)
		curva!(p, I_reg_grelha, Iexc_nec; k=1, label="U = $(U_reg_const) V, n = $(n_vz2) rpm", marker=:circle, lw=3)
		# corrente de excitação em vazio (I = 0), a tracejado
		isnan(Iexc_nec[1]) || hline!(p, [Iexc_nec[1]]; color=:red, ls=:dash, lw=1.5,
			label="I_exc em vazio (I = 0): $(round(Iexc_nec[1], digits=3)) A")
		p
	end
end

# ╔═╡ 227bfc6a-7bce-438e-808f-22b0ab2f2e2e
let I_g = I_reg_grelha
	ΔUT_reg = (-ajuste_sep.m) .* I_g          # V, ΔU_T = R_eq·I
	ΔUr_reg = Ri_11 .* I_g                     # V, ΔU_r = Ri·I
	ΔUo_reg = ΔUT_reg .- ΔUr_reg               # V, RMI + escovas
	p = plot(xlabel="I (A)", ylabel="U (V)", title="Quedas de tensão e E₀ necessário (U = $(U_reg_const) V constante)",
		legend=:right)
	hline!(p, [U_reg_const]; color=paleta[1], lw=3, label="U = $(U_reg_const) V")
	plot!(p, I_g, ΔUT_reg; color=:black, lw=3, label="ΔU_T = R_eq·I")
	plot!(p, I_g, ΔUr_reg; color=paleta[3], lw=3, label="ΔU_r = Ri·I")
	plot!(p, I_g, ΔUo_reg; color=paleta[4], lw=3, label="ΔE (RMI + escovas)")
	plot!(p, I_g, U_reg_const .+ ΔUT_reg; color=:red, ls=:dash, lw=1.5, label="E₀ necessário = U + ΔU_T")
	p
end

# ╔═╡ 8cb38b9f-b0f3-4e27-9d13-5a1e031ae472
#=
Função para alternar automaticamente os logótipos consoante o navegador esteja, ou não, em "modo escuro".
Cada imagem pode também funcionar como ligação, aberta num novo separador.

Fonte: R. Luís, "Notebooks Computacionais Aplicados a Máquinas Eléctricas II", ISEL, https://ricardo-luis.github.io/me-2/
(código Julia sob licença MIT; desenvolvido pelo autor com apoio de GenAI - DeepSeek Chat, setembro de 2025)
=#

function logo_adaptativo(logos::Dict, links::Dict=Dict(); default_logo=first(keys(logos)))
    # Configuração inicial
    config = logos[default_logo]
    light = config.light
    dark = config.dark
    height = config.height
    url = get(links, default_logo, nothing)

    # Serialização segura dos dados
    logos_js = join([
        "\"$k\":{\"light\":\"$(v.light)\",\"dark\":\"$(v.dark)\",\"height\":$(v.height)}"
        for (k,v) in logos
    ], ",")

    links_js = join(["\"$k\":\"$v\"" for (k,v) in links], ",")

    # HTML/JS com template seguro
    return HTML("""
    <script>
    (function() {
        const container = document.currentScript.parentElement;
        const logos = {$logos_js};
        const links = {$links_js};

        const img = document.createElement('img');
        img.height = $(height);
        img.style.transition = 'opacity 0.3s';
        $(url !== nothing ? "img.style.cursor = 'pointer';" : "")

        function update() {
            const isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const logoName = img.getAttribute('data-logo') || '$default_logo';
            const logo = logos[logoName];

            img.src = isDark ? logo.dark : logo.light;
            img.height = logo.height;
            img.style.opacity = 0;
            setTimeout(() => img.style.opacity = 1, 100);
        }

        $(url !== nothing ? "img.onclick = () => window.open(links[img.getAttribute('data-logo') || '$default_logo'], '_blank');" : "")

        window.matchMedia('(prefers-color-scheme: dark)')
             .addEventListener('change', update);

        update();
        container.appendChild(img);
    })();
    </script>
    """)
end;

# ╔═╡ 940007d8-3ef1-42cd-b29b-dd62e2693365
begin
	# Logótipo do ISEL (versões para modo claro e escuro, embebidas no notebook, a partir das imagens do repositório dos notebooks da UC)
	my_logos = Dict(
		"isel" => (
			light="data:image/png;base64,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",
			dark="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAACRCAYAAABT2Ak0AAAU3klEQVR42u3dfZAkdX3H8c93ZvYOeYoBk4oiCMJJDFIVSVSUhzwIHtwTDwcoD8GyEsuCGI2YypMRhAsxEdGEmEpCCIpgisiDx3F3cMDymARQTKUqakyFokwqpVVRed7jYWfmmz/622yz7O3OzPb007xfVVN7x+nuTs+vu9/z6+luc3fXZOhK+r6khyVdL2mzmfXdvW1mPQFLcPeWmfXjz4dLOkfSeyStkrQHS2i4xSnJJM1IWmVmP3B3MzOv2GveNrOeu98m6QRJPUntHJ73U5IOMbMfVfF5o9LboY6Zdd39ckkXxL6tk8OYdElvNrP/zG7r0FydCXuuB8TjdEkPufsfmNm9RCCGCIF9JW2SdC7RBwCoq9YEzjr043GkpHvc/Xdix95xd2NIYBfvuHvufpikhySdF/HXi7EEAAABWGEWz7mV2Xlf5u6fNLOulndoB82Nv667/5ykOyUdImk2/rk9gesQAKABOhP83NtKZgS7ki5xd5nZJnfvSOrxmRzMi7+7JL023jhMsXQAAHU26bMXFiGYRuAfMROIefH3ZiUzf2n8MTYAAARgwyJwUxqBMRMI4u8uSa8j/gAABGDzI/ATRODEx9/PEn8AgKYicBaOwD+OzwReymcCiT/iDwDQNMwALh6Bf8hnAic2/vYj/gAABOBkRuClcbFoDgdPRvwdSvwBAAhAIrAr6U+IQOIPAAACcDIj8PeJwMbG35si/l5P/AEACEBkI/DTRGBj42+a+AMAEIBYLAJ/jwhsVPwx8wcAIACxZAT+KRFY6/hrx2u3KuJvf+IPAEAAYtAI/F0isJbx14v4myb+AAAEIIaNwD8jAmsVf51M/DHzBwCYaJ3YCWJh7QEi0M3ssvRzZSyySsZfetj3kIi/A5aIv74k7vwy5pcl1iW2PwBQUgAyA7JrfS08S5qNwM/EbeOIwGrGX2eE+GNmvDh7x/oEACg4AO9gMbwi7lzSqyQdE0FgC+yk5kegm9lnicBKxV8683dwxN8bloi/9N8elfRYZixgDC9PLN/n4wEAKDIAzWw1i2GXAfFJSZdE5LUXicCepMsiAi8nAisTf72Iv+kB4q8bb4gelLTWzJ5gKRb8zsuM2AaAogLQ3TkEPK8dIuzMzDa5uwaIwFbExWfjcDARWJ34G2TmL42/hySdaGZPxYk9fXF4cuwvl5n1WQwAUHAAmhkfwl44IiwibpO7m6SLB4jAbkSgm9nniMBS4++NEX8HDhh/D0s6IeKvzesGAGgyPuy+C3E4qhcRd4mkizR31vRCh6qyh4Mvd/cLuERMLeOvxZsiAAABOOERmEZcROCnBojAViYCP0YEFh5/B0X8HTRg/H094u/JiD8ORwIACEBImpsJvHheBGqJCPycu/82EVho/E0TfwAAEIDLNu9w8MVKPg/YiZBYaibw80RgYfE3yszfE/E9iD8AAAGIRSPwU0rODB70cPDn3f2jEYFTLM3c4+/AiL83Dhh/35gXf3zmDwBAAGKgCLxoXgRqiQj884jAWWYCc4+/6SHjbzXxBwAgALGcCNw0ZAR+hMPBucbfIDN/vXiNHhEzfwAAEIA5ROCFEYFtJRcOXioC/4IIzCX+3hDxd7CWvrdvO+JvtZk9zqVeAAAEIPKKwL/NRN4gEfhbRODY4y+9q8v3lcz8Pc4JH0Dt1vtWPLgrD0AAVioC5e4tJWeVptGhASLwikwEcmLI4PF3QMTfIZq7M4uWCMD/M7MfJzdoYeYPqFP8mVk/Hk4EAgRg1UKwL2n3Qf/n8yLww3FiCBE4WPxNZ+Jv0NnTTsSfszSB2qz3U2bWd/dz3f3azH8nAoEccPgxP8McVsxG4F+6u8zsC9w7eNH4218vn/kbZuw68QfUar3vxBvjjZKultSO2cCz43CwWKeB5WEGsDzzI/A3+UzgovE3LWmV5s7oBdDM9X4qtoUbJX01tpMvSjrL3b8SR1yMmUCAAGxKBH7B3c8nAl/aCbTmzfyl8ddm2ACNjr9Zdz814s+UfJZ3haRZIhAgAJsagX/l7h+KCJzY0Ek/+O3u+0X8vUlLn/ABoJnxl+6npjIReB0RCBCATYvAv3H3Y2P2a+KCJzbm5u4rJd2ciT8O+wLNj79TNHfY1xfYR6UReDYRCBCATYrA1JXuvluyXZy4DVt6h44LJL09NvbEHzAZ8XfDIvGXjcBuROC1RCBAADYifmLDdqikM2PDNjGzgHGplq677yPp45q7iweAZq7z6dm+Jw8Yf6lOvDk8x92/TAQCBGATpJ97+UD8fZLuWpHG3jpJ+w64IwBQz/hLz/Y9WdKNQ8RfKj0c/GtEIEAANuU1MUlvdfefjpMhJmWDll7X6/j4M9f5Apobf7PufpKGm/lbLAKvIQIBArDO0hnAPSUdNGGvUzrbuUpzJ8YAaGb8bVAy89fW8mb70wg8lwgECMDabyPj694TtFOwuNdnS9KrGQJA4+Pvphzib6EI/BIRCBCATQnBSWLixA+g6fGXx8zfQhHYlfT+TARy72CAAAQAlBR/6dm+6yP+OhrPSV7p2cHvd/er0zeVRCBAAAIAio2/9GzfdUoO+44r/lJTkl5QciWFK2ImkH0dQAACAAqMv9mIv5sLiD8puaPSSkk/lHRjzP5xRQFgHu6wAAAYZ/ytLTj+2pIel3SimX0zvbc4rwjwcswAAgCaFn+rI/46xB9AAAIAiou/NRF/UyXE3yMRf11eEYAABACMN/46mfj7WkHxl94z/AlJJxB/AAEIACg2/rrufmKB8deL7/+Ekpm/bxB/AAEIACgm/qYy8bdZxR72TWf+iD+AAAQAFBh/s+5+QsTfigLj78mIv68TfwABCAAoL/7GfeFl4g8gAAEAJcVfesLH6hLj72HiDxgNF4LGpOysuBdoA5gZd3SoTvx1I/5uUXLnjXHHX3q271NKLvJM/AEEIEA4TFB8tCWZpD4X+S01/t5TcPy1Iv5OMLOHiD+AAASW7D93X8liaETIv2BmvXkx2CfwiT8ABCCQSndKh0r6LxZHE/rDn5b0qKR7JW02s/+Of+B+r+Nf+OkJH8dH/O1WcPydSPwBBCAwjClJ+7MYGuMtkk6WtMnd/07SxWb2tLu3s7ODGFv8bSk4/p6O+HuQ+AMIQGCUnQka0iPx2EvSBZJWu/tpZvZdZgLHEn/p2b7HEX8AAQjUDZc8amYIdiUdJmna3Y8xs8eIwNzjr1ty/P0L8QewUwSAlCk5vN+V9DpJN6Qn+3DZn1zj790Rf68qMP6ekbSG+AMIQADYlY6kWUlHSDo/Zv/aLJbc4u/WEuLvRDP7Z+IPIAABYDFtJYeEP+7ue0jqMQu47Pj71ZLibw3xBxCAADDotswl7SfpmLguINu3esbfPxF/AAEIAMOEhEs6Nv7ODOBo8fcrEX+7Fxh/z0paS/wBBCAAjMIkHZQ2DYtjpPjbWkL8rTGzB4g/gADEBO+LxDX7MHr8SdJPsChGir9fLin+1hJ/AAGISd1zm7m7W5zB+TRLBDmEIOoRf/cTfwABCMajJH1PzAQCRcXfL0X87VFg/M1IWkf8AQQgIM3N3NwnZnGAouJvWwnxt9bM7iP+AAIQSHcQkrRZ0nOau7QHgObE3zriDyAAgZeYWd/d22b2v5KuivHJDgLIP/6OVXmHfe8l/gACEHjFzsLdW5IuUvJZwCkiEMg1/o5RMvO3Z4Hxt1PSeuIPIACBBcUdHGRmT0jaqOSM4PRerxwOBpYff9tLiL91ZnYP8QdUR4dFgApGYHoo+F/jZvT/IGlV/HO68zBxoghvRDFM/B2t8mb+iD+AAAQGisBeROAj7v4OSRdK+oC4yC8wavxtl7RXCfF3N/EHEIDAsBHYisPBH3P3yyWtUXKv14NiZ9YRh4Zr+fLG69aRdIiYBWxa/D0naQPxBxCAwKgR2Hd3k9SKs4OvjAfqHScWd395jaRHlczsujisn3f8HVVS/K03s2niDyAAgeVEoEvqxdnB6bUB++kJIwCIPwAEIJobgn3Nuz1czA6ihi+nO/0+xvh7V8Tf3gXG3/NKDvsSfwABCIw9CqmIeoaK4hAwC2M88XdbSfF3F/EH1AMfvAaA5sTfO1XezN+dxB9AAAIAio+/25ScUFNk/J0U8TdF/AEEIACguPg7ssT4uyN+j1leEYAABAAUF3+3Fxx/L8yLP2b+AAIQAFBQ/L1Dxc/8EX8AAQgAKDH+bpf06oLizyL+TjazHcQfQAACAIqNv7dn4q9XUPy9GPF3O/EHEIAAgOLjb0cm/tpjjr+WpFlJp0T8cbYvQAACAAqMv7fp5TN/446/7MzfbRF/nO0LEIAAgALjb4eknyww/tKZP+IPIAABAAXH3y+WGH/buc4fQAACQNUZ8ZdL/J2aiT8+8wcQgABQaeOYqfKS42+fAuOvG/G3jRM+eKMDAhAAqi6NtB+NYQf5eFEhmIm/X6hA/HHYt7qeLPqNCQhAAKiyb+X4vdKI/HYhBTsXf0eUGH9bib/ajHMTM4EgAAGwPZMk3Z0Jm2U3WXy9a9zbzHnxd4ekfQuOv43EXy2k4/pBSTtjTDITCAIQwETqRcg8JOnf3L1lZssOQDPruXtL0jfjYfGzmhR/vYi/Wznbt/rMrO/ubTP7gaTN4xqTIAABoA7SmLnQzFz5HhaziMkL4/v2c/7d0/h7q5LDvmXGHyd81IO7u0m6VMnsrYlZQBCAACbMrKQpSX9tZnfG7EhuMyIxC9g2s+2SroqflcssWcxUzkb83SHpNSXE3xbO9q2XeEPSMrPvSPpEjBdePxCAACYu/m6R9BF3byv/GTpJ6sf3Pi9+Vh4ROBWH844oKf5Oy8Qfh33rF4HpG5PPSLoyzzcmIAABoMq6sdPbIum0iJp+HALOe2frEU+9+Flb4mePOuvSlvRDd3+LksO+ZcTfLcRf7aWfB/yQcp6dBgEIAFU0K6kj6VZJGyNqbBzxNy8CXzp0Gj+7M+IOd0bS0ZLuLDj++pJOJ/6aIX1jEhH4QUl/TwSCAATQ5PibWiD++uP+wfEz5kfgMDvc9OSUvSRtlfQzEWVFxt9mzvZtbAT+BhEIAhBAE7dBafxtjQDrFhV/C0RgN36HrSPscHeXtIeSMzfHuR2eH39f44SPRkdgKyLw6hEjkCZg4wsA4xXX19upwS9fkY2/U8uIv11E4KkjRmDel6sZNP6YGWpuBHrMBP76iBE4E+slCEAAGItORNSRSmbD+kvEUHrCx7ay42+RCNym4U4MKSr+ziD+JioC+5kI/OIAY9Iy4+XYGNdtliaw9CxGJ76e74lZX75efD0uvjcrI5q4zhzr7k+7ez8eu/JifN3q7ivc3ao0S+HurfidVsTvmP2dy9CL5dlz91Pjd5xi5E3UOvbSOuLuVw8wJtPxMsuYAQhAYJzryzHu/kxm57NU/G2rYvztIgK3lRiB2fjbyI6cCIw/f3HACOy7ezcTgR2WJEAAAuOIv17d469CEdjLPE5jB455EfilAcZkLxOBp/AGAiAAgbzWk6PjsO+g8bfd3VekgVWD55nubFfE715UBC4Uf+y4QQQCBCBQm/ibzcZf1Wf+ForAzEzg9hy3C0sduuu5++nssLFEBF4zwJjMRuDJjCmAAARGXT+OGjL+bnP3lXWLvwUicGU8l3FFYHbmj/jDsBE4yEzgrLufxNgCCECA+KtGBPYyO2niD8NG4JeJQIAABMa1XrzL3Z8aIv5ud/eVaUA1YDmkO9uV8dzy2kb0MzvnM9gxo6AI3JBdvwF2dAQgQPwVF4HZ6ya+l/jDMiPw2hEjkDEHdnYEIPCK2HnngPGX7nR2NDH+dhGBO5ZxdnA/85X4Q1kRuL6p6yowyob9vDEE4LvTFZUljRqtE0e5+5NDzPztcPfdmr5DyWwrdstE4OwIh31nMod9eXOIvCLwuiEi8MXMTCD7p5oyd/8WiyEX+0h6rfK9wfv3JM1U9Pl2JXUkXWNml8W9J3vL2RCZmcfGaKukA5Tcn5J3mPVzsKTdlnj90vFzp6QNZva8u7fKvLdvURFoZv0I3i2Sjs8si0HNSPqOpD1jGaO60nXgu2Z2Wrqdq1oEKu6r7e7XSTpb0qySewgv+H/R3P2D/4OXuL46kg5jMeQb1Tl+rwNr8Hz3z/l5m6TDJb2eoVTv1iH+FhjcyU62Fc95w4gRuIektzHEaqVd4THp7p6+OTkngvCsRSLQMus3/VDzAOQdZH7hkvdUeJVfm3SH9eIYvvfOeO7MADZvXUjHzV2TFn+LROCtko4bMgLZbtdDug3bWfExmY3AsyMCzxwgAp2XuN4ByA62uloV/91aY4je7PcW47NRJj7+FonALUNGIOtFvbbjrRqMyWwEnuXuGiAC+fwfgQEAi5qNsJmO+HtuUuNvgQh8TtKGWDadWFZAKREoydMIlHR9xB9jkgAEgKF1YycyLWk98bfLCFwfy2gqlhlQagQq+Szg9YxJAhAARom/jqS7ib+BI/DuWGbscFFqBCo5xHuWpH8Us9MEIAAQf0QgJiICFRF4ZkQgh4MJQAAYKP7uifjbSfwNHIE7IwLvIQJR9pjU3EzgmZK+SgQSgAAwSPytI/5GjsB1RCAqMCazh4PfRwQSgACwWPzdK2b+8ojA9bEsiUBUKQJvIAIJQABYKP7WmdkM8bfsCJxRMhNIBKIKEagFIpAxSQACIP50H/E3tgi8jwhE2WMy89f3SbpRnB1MAAIg/iStJf7GFoFriUBULALfGxHI4WACEMCExt/9xF9hEXg/EYiKRKBHBN5EBBKAAIg/4o8IBBEIAhBAA6X39n0g4u9Z4q+wCHw2IvAB8fkrlDsm0zOD+xGBNxOBBCCAZurHxn0qAmQN8VdaBK6J1yDd4TpLCGWMyUwEnpGJwG78NxCAAGoovf5XPx6t2LjfKmb+qhCBayVtj9fEMq+TE4QoMQKvUjI73WJMEoBo7tixMX5vxmcFtu3xaMXjMUkfNrMNZvYM8Vd6BD5jZmslfVTS/2ReJxvTugm2ZYtFoCT1zeyDSm4d923GZHV1JD3LYsAIejF+XhjD935W0ky8a2SDUW789ST9WNK/S9oi6SYze9Ldbd5GH+VEYPo6XOHuX5G0Ucms4OGS9pXUFrMuZfKIn5kJGZPu7hZvTq53982STonHz0v6KSWz1YzJCvh/ArKPpm9QT2cAAAAASUVORK5CYII=",
			height=70
		)
	)

	my_links = Dict("isel" => "https://www.isel.pt")
end;

# ╔═╡ 55ae9aae-d7ea-45e5-9aed-b50fbffa1984
TwoColumnWideLeft(logo_adaptativo(my_logos, my_links, default_logo="isel"),
md"""
$$\begin{align}
\\[-5mm]
\small{\textsf{Licenciatura em Engenharia Electrotécnica}} \\
\href{https://www.isel.pt/sites/default/files/FUC_202425_3894.pdf}{\textcolor{Bittersweet}{\small{\textbf{Máquinas Eléctricas II}}}} \\
\small{\texttt{Última actualização: 11·10·2026}}
\end{align}$$
"""
)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Handcalcs = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
DataFrames = "~1.8.2"
Handcalcs = "~0.5.4"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "c9f42a69033748c0ab3a359e18fa31832b768380"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
registries = "General"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
registries = "General"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CRC32c]]
uuid = "8bf52ea8-c179-5cab-976a-9e18b702a9bc"
version = "1.11.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1fa950ebc3e37eccd51c6a8fe1f92f7d86263522"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.7+0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "REPL", "UUIDs"]
git-tree-sha1 = "cfb7a2e89e245a9d5016b70323db412b3a7438d5"
registries = "General"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "3.0.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
registries = "General"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
registries = "General"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
registries = "General"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
registries = "General"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
registries = "General"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
registries = "General"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.5.5+2"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
registries = "General"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "54b76cbb40d9a0f5368c880725b2f141da77c94f"
registries = "General"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.2.0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
registries = "General"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "5fab31e2e01e70ad66e3e24c968c264d1cf166d6"
registries = "General"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.8.2"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
registries = "General"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
registries = "General"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
registries = "General"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
registries = "General"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
registries = "General"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
registries = "General"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2bfb1e047e2ad0a5ca94365340bde8005d637568"
registries = "General"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.8.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
registries = "General"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "7a58e45171b63ed4782f2d36fdee8713a469e6e0"
registries = "General"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.1.2+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
registries = "General"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
registries = "General"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
registries = "General"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "70329abc09b886fd2c5d94ad2d9527639c421e3e"
registries = "General"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.14.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
registries = "General"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "64bbbb7d1499297751b536dd39c58b20750ab1db"
registries = "General"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.5.1+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "4d777f73c46b46b8b5276206059cf8a195499314"
registries = "General"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.27"

    [deps.GR.extensions]
    IJuliaExt = "IJulia"

    [deps.GR.weakdeps]
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f8eb8f7ba13ea75083531647fc8faeda8d541f07"
registries = "General"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.27+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
registries = "General"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
registries = "General"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "090526e65de8f69648ac156daae153de8b56df62"
registries = "General"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.88.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "69ffb934a5c5b7e086a0b4fee3427db2556fba6e"
registries = "General"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.16+0"

[[deps.Handcalcs]]
deps = ["AbstractTrees", "CodeTracking", "InteractiveUtils", "LaTeXStrings", "Latexify", "MacroTools", "PrecompileTools", "Revise", "TestHandcalcFunctions"]
git-tree-sha1 = "6c1d1cc641e110b551ded513dbe3d2249c7ed558"
registries = "General"
uuid = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
version = "0.5.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9d9531a9cb63a9edc33836414e82a07e81710de2"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14004.0+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
registries = "General"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
registries = "General"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
registries = "General"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InlineStrings]]
git-tree-sha1 = "06b65886c7577a3784d616e29f1302c2e36e389d"
registries = "General"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.6"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
registries = "General"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
registries = "General"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
registries = "General"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
registries = "General"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
registries = "General"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "633b5a34494e711f694ccbc88a6e00102f10238c"
registries = "General"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.9.0"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "037babc10853eeb8e585418922246cb97b8e5b74"
registries = "General"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.2.0+1"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random"]
git-tree-sha1 = "24a00d415eac260385b0f260340457664a7b2bca"
registries = "General"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.11.5"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
registries = "General"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "39bca05343661c347aae0bca57a5994a0bf4f08d"
registries = "General"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.2.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e5b100780d4d30d63b4618d7930d48af409c1772"
registries = "General"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "23.1.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
registries = "General"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "df7566479bd64f20bd16b09960145e70160ffb3b"
registries = "General"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.12"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "1.0.0"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "Zstd_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.18.0+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "PCRE2_jll", "Zlib_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.1+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "OpenSSL_jll", "Zlib_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.103+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
registries = "General"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
registries = "General"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
registries = "General"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc3ad4faf30015a3e8094c9b5b7f19e85bdf2386"
registries = "General"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.42.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "aebd334d06cee9f24cea70bd19a39749daf73881"
registries = "General"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.3+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d620582b1f0cbe2c72dd1d5bd195a9ce73370ab1"
registries = "General"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.42.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.13.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "bba2d9aa057d8f126415de240573e86a8f39d2a1"
registries = "General"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "1.0.1"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "e16fd69604bef06cb3fe9da09b315005c9c34564"
registries = "General"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.9.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
registries = "General"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
registries = "General"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
registries = "General"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
registries = "General"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2026.8.13"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "dbd2e8cd2c1c27f0b584f6661b4309609c5a685e"
registries = "General"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
registries = "General"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.30+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
registries = "General"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05f45c2e0de6259db764adbfd2f1dc6d3f8de13c"
registries = "General"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.46.0+0"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
registries = "General"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools"]
git-tree-sha1 = "663e8b48b789916221e0765393b289ca6c88f24e"
registries = "General"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "3.0.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "e4a6721aa89e62e5d4217c0b21bd714263779dda"
registries = "General"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.46.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "Zstd_jll", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.13.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
registries = "General"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Reexport", "Statistics"]
git-tree-sha1 = "f20e945b895d2009c6c28d8bbf40a5cd846f7c2f"
registries = "General"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.5.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "83bd514e8ff16b5858ac54c53fa0bcf6002a3b00"
registries = "General"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.7"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "90b41ced6bacd8c01bd05da8aed35c5458891749"
registries = "General"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e189d0623e7ce9c37389bac17e80aac3b0302e75"
registries = "General"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.83"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
registries = "General"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
registries = "General"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "5005266de4bfe50e53ff44a5cb5c540b6e47a254"
registries = "General"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.6.0"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1b8aa19f229b1cea7fc93874a52e49db6a854450"
registries = "General"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.4.8"

    [deps.PrettyTables.extensions]
    PrettyTablesExcelExt = "XLSX"
    PrettyTablesTypstryExt = "Typstry"

    [deps.PrettyTables.weakdeps]
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"
    XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "4fbbafbc6251b883f4d2705356f3641f3652a7fe"
registries = "General"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.4.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "144895f6166994730ee7ff8113b981fc360638f1"
registries = "General"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.10.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll", "Qt6Svg_jll"]
git-tree-sha1 = "159d253ab126d5b29230cf53521899bea4ef4648"
registries = "General"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.10.2+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "4d85eedf69d875982c46643f6b4f66919d7e157b"
registries = "General"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.10.2+1"

[[deps.Qt6Svg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "81587ff5ff25a4e1115ce191e36285ede0334c9d"
registries = "General"
uuid = "6de9746b-f93d-5813-b365-ba18ad4a9cf3"
version = "6.10.2+0"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "672c938b4b4e3e0169a07a5f227029d4905456f2"
registries = "General"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.10.2+1"

[[deps.REPL]]
deps = ["Base64", "Dates", "FileWatching", "InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
registries = "General"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
registries = "General"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
registries = "General"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
registries = "General"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
registries = "General"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CRC32c", "CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Preferences", "REPL", "UUIDs"]
git-tree-sha1 = "82ac67271b84f674fccccbc9f92b106941fb8c65"
registries = "General"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.17.1"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "1.0.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
registries = "General"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "084c47c7c5ce5cfecefa0a98dff69eb3646b5a80"
registries = "General"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.10"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
registries = "General"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
registries = "General"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.13.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
registries = "General"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
registries = "General"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "IrrationalConstants", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "adb9da019510162e67a4493fc235c23203d8b09e"
registries = "General"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.13"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "773065c6e0e903924a9d838259be74338422aef2"
registries = "General"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.5.0"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "b814d5005d6a529d740ffe06f8a86396f6501138"
registries = "General"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.9.2"

    [deps.StructUtils.extensions]
    StructUtilsLazilyInitializedFieldsExt = ["LazilyInitializedFields"]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    LazilyInitializedFields = "0e77f7df-68c5-4e49-93ce-4cd80f5598bf"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.10.1+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
registries = "General"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "a94d9bdda1b7bed0046cea645639ab3f62196fac"
registries = "General"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.14.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
registries = "General"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TestHandcalcFunctions]]
git-tree-sha1 = "54dac4d0a0cd2fc20ceb72e0635ee3c74b24b840"
registries = "General"
uuid = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"
version = "0.2.4"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
registries = "General"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "908fec9df6c5de98548ead82a468c95ccf6cd263"
registries = "General"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
registries = "General"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
registries = "General"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
registries = "General"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
registries = "General"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e52eca002a11c30a858185efdfb15311e1c7a6bf"
registries = "General"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
registries = "General"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
registries = "General"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "808090ede1d41644447dd5cbafced4731c56bd2f"
registries = "General"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.13+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
registries = "General"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
registries = "General"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
registries = "General"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
registries = "General"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
registries = "General"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "dcb316b3ce0941f195537dda56bea4517fcd3ff5"
registries = "General"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.4+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
registries = "General"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
registries = "General"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
registries = "General"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "58972370b81423fc546c56a60ed1a009450177c3"
registries = "General"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.19.0+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
registries = "General"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
registries = "General"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
registries = "General"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
registries = "General"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
registries = "General"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
registries = "General"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
registries = "General"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
registries = "General"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
registries = "General"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "2e59214e017a55cb87474a00fa76035c82ac0e17"
registries = "General"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.47.0+2"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
registries = "General"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl"]
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
registries = "General"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
registries = "General"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ef17c47d22224aaecc76e597ab21a072e025cf7b"
registries = "General"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.14.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "cb007192783c56d8249db4cf0e3495001edfe414"
registries = "General"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
registries = "General"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "28e57478e8a160d346a19c28b3fffb9273bcc9c2"
registries = "General"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.134+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
registries = "General"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
registries = "General"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
registries = "General"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e51150d5ab85cee6fc36726850f0e627ad2e4aba"
registries = "General"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.58+0"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "7dbf96baae3310fe2fa0df0ccbb3c6288d5816c9"
registries = "General"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.23.0+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
registries = "General"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
registries = "General"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.67.1+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.8.2+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
registries = "General"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
registries = "General"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
registries = "General"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"

[registries.General]
url = "https://github.com/JuliaRegistries/General.git"
uuid = "23338594-aafe-5451-b93e-139f81909106"
"""

# ╔═╡ Cell order:
# ╟─55ae9aae-d7ea-45e5-9aed-b50fbffa1984
# ╟─49477e5b-ec8b-4dae-8a7c-cf86c4f283ba
# ╟─cb2aba91-328d-453c-a6a4-b58bdaac45e6
# ╟─5b4dfc55-4b26-45fc-aee7-b74195ac2c73
# ╠═ead31e42-3ea5-4833-9659-43543197bb1f
# ╟─8d840560-a311-4f8b-8e2d-f52f5818fc15
# ╟─b18d9dc8-2920-43ac-a9bf-c8b989cc5ef2
# ╟─3c751441-672e-4bcc-aa46-47f50b4ddb1b
# ╟─d7f65207-6978-4490-83b0-129356004c47
# ╟─c8d37d56-5780-4278-b810-5b013c7a3994
# ╟─0c244854-420a-4ea4-ad0a-b9d4e8c12b88
# ╟─de8a4879-e2e3-45ff-88b0-b652cbd5c421
# ╟─669f3dfc-5138-4ed7-8606-0c47a7680de3
# ╟─1edf5a6b-5a27-495d-869a-b4092c333ca1
# ╟─3220fabe-078a-4e15-ad9b-e1eaea290d93
# ╟─6dde47e1-033f-4384-a841-cc9ac52b4a7d
# ╟─fe34797b-f3a2-4174-be02-f51443fe1766
# ╟─0ff205db-0f7c-4072-81cd-5072997b356b
# ╟─c74a26e7-4fcd-40f7-985f-0bf22c25de3b
# ╟─f2f04cd6-a284-4578-a51c-1d5871c42fbd
# ╟─ac256418-9873-4056-9c8b-92948905e9c8
# ╟─c6d9e9a7-cdc1-4e36-9122-627e7e23366b
# ╟─0879b867-86d3-4fea-9325-cb9a9378669a
# ╟─de9d3a68-a218-4ef2-953b-743952fd50e6
# ╟─1c6e4b5b-ae4a-4681-9018-e98de0892b24
# ╟─aecc3a01-f0a0-4ec5-98b3-a667c918c21e
# ╟─d75e4270-86b1-4efc-a9b9-f6916c98a70b
# ╟─cc5c9add-b887-435a-9a3f-260a456b37b6
# ╟─ef1805c1-1ca7-441e-803a-a45bf2414e26
# ╟─d855d53d-efd8-42df-8f81-bb0f7a8b35fd
# ╟─c84e6d57-4c72-4fea-8f17-8892124af01b
# ╟─b258eeb3-248a-466a-b6e3-f323e630d92d
# ╟─e37a8e7d-a9b7-44a1-9a19-6edeec501535
# ╟─e4c39c28-c16e-46ce-8adb-591fc2811a32
# ╟─97f3e468-2f8b-4835-a58d-f7f6be44fcd7
# ╟─81d39162-63a3-40fb-9146-03102e8f743f
# ╟─e6b6aae2-340a-4ef5-936a-743e23c49881
# ╟─87db8358-81b4-440e-8ec7-750e24afd80b
# ╟─e39d4df6-f8f3-4563-91e7-995e95bce75d
# ╟─686d37f2-c05d-4266-8c23-d2b0b12bd19f
# ╟─47fc0cdd-f1fa-4e51-bb0f-3b8f36d93f66
# ╟─33981584-9369-47b6-a7a2-c0e18e64758f
# ╟─cc709138-586e-452b-9e50-b8fa5965d6e6
# ╟─4eb20e8d-555b-49fe-b3e5-291a9e489894
# ╟─f0459a1a-8e6b-4615-ae5f-3e753232430d
# ╟─d2a36534-325d-476e-9069-06bbb86bd2ca
# ╟─820bb91b-7339-4d1b-b7f6-a680ac33716e
# ╟─dfe04e63-3704-448a-a294-253d18386f09
# ╟─d3d9824c-d7df-48ec-abae-2acb5430212b
# ╟─c512dc2c-83fe-41e9-af26-5570c00be70f
# ╟─5abcf517-b77b-48b5-aea2-a8e7b98745e5
# ╟─74650170-e03d-43bd-846f-1bf75e83253a
# ╟─caa22c20-066e-45da-b33f-1a3ab568f6b7
# ╟─035ff22f-9527-4a03-88c4-12d52bcec829
# ╟─c2d747a3-d376-4e3f-9266-8d3e7bc79a18
# ╟─6402d75e-7467-4b24-8088-a5f690c64cad
# ╟─278c84fd-b6b6-457e-9227-8b5b4eba9c10
# ╟─89ab6e23-489b-41ec-9534-ba1fce61c240
# ╟─c25f7278-b8bc-41a5-9ba6-04e49aacb393
# ╟─e69def99-b256-4130-b9e5-d2b5171a70cd
# ╟─c1daf204-959d-4749-a6d4-a0c1e42eb44b
# ╟─b366550d-5d21-42a1-99e6-335a846b0085
# ╟─0f12f102-f0f7-4205-8fd3-3c1905df13b4
# ╟─8f043af8-e8b2-4363-9184-ce2c54ccbd21
# ╟─dcacb1a2-6a5d-40d1-b650-5416f478873d
# ╟─36fb4e06-e5a6-403d-b656-944e181347d7
# ╟─33fb0829-c3ae-4757-b1ad-059d0dd8f6fc
# ╟─222ff8c3-0305-4b8c-a5db-e5a73456ea46
# ╟─7a8b0221-acee-4c69-a249-9c92f115c2ce
# ╟─d5670b0c-d3b2-49c1-b74b-98a8efe719e5
# ╟─e96058f4-4111-40d5-b34f-e5d31e24c9af
# ╟─96375eab-8202-412b-8ec8-5220300b2c6e
# ╟─38bcbb19-9ecb-48b0-9b59-e10850840f59
# ╟─3035d419-e193-46f2-a8cc-992651ac08b3
# ╟─92245908-1b37-4fc2-b664-170b7b48a448
# ╟─3ca00a5d-10b8-43c4-82ba-2b5a806760a3
# ╟─a44a65b7-dade-4a17-a72b-7bcc137c5b99
# ╟─7344644a-61d5-4dbe-9937-67ab96e75077
# ╟─95c3d564-e6c6-4a85-8305-b96c4c78b246
# ╟─2f927d24-9a80-4747-9415-6bb7e1e9f2f0
# ╟─2e657109-261e-4091-97ba-9d093475a1cc
# ╟─04507d0e-dbc5-4356-9b80-9b0372873f19
# ╟─5b93746a-8b49-4091-8b19-dd546cca1194
# ╟─1ff09567-c05d-421a-9fe7-628bf0e3c676
# ╟─2383e560-f955-44d3-94b3-8173e3f647da
# ╟─47892145-d49e-4307-b351-8022af780c66
# ╟─0cdc7bf8-fb96-462d-a4ca-9a265bbf148a
# ╟─01f72d8f-c9ba-458c-9163-3162fc2f67b6
# ╟─5c8af6f1-e296-4360-aaad-4496b224ed50
# ╟─41435062-7fe4-485d-ab8a-d7e4fd380d62
# ╟─341e2e52-a9fa-418c-a003-c78c925b95b2
# ╟─e95407b9-08c4-4687-aa0d-b6c82b25b499
# ╟─60b10931-cdd0-4815-bcf6-21d18e04c7fe
# ╟─6741a499-ef19-4b60-8901-aef9b20dd0bc
# ╟─2adb39ad-36aa-47cb-9a3e-5431681a6957
# ╟─60c28e92-fb65-4a29-9e74-9cf1af6a8aea
# ╟─3ce6c57c-0f15-44b9-b18a-d250ceac3f44
# ╟─cdacb1e0-486f-466f-90d6-9e3267cd2fc8
# ╟─c8fe90c6-2515-4725-90bc-862802231b86
# ╟─309e6d46-9af8-4851-88b8-39cbad2a1c2f
# ╟─b5f0f838-351d-4314-9787-b392dc24e643
# ╟─31a4f26b-1a5e-49c0-aea1-0dc27d89da6d
# ╟─5555543c-a8b3-4349-b00e-55302c0a3e7b
# ╟─4e75afb3-68d0-4d60-aef6-4ddb27938c6c
# ╟─c04ce852-c270-4f0c-9f26-fc4b91aac934
# ╟─06c56f64-34a3-40d2-88d6-03ef31bfd844
# ╟─6e651654-608e-4142-b24d-de9d4741f49c
# ╟─3e5c01b7-2d41-47f1-ab97-d60217b20522
# ╟─be18c701-5efb-4e6d-af39-30686b851079
# ╟─c50754c1-9322-4a94-b0cb-a5144067930e
# ╟─6205f92a-d010-4b73-95b1-f5b9b32d8481
# ╟─1b1af362-13ac-4b67-ac6a-731223ad01aa
# ╟─a22914bd-97fc-4886-afe0-ce8850f51f60
# ╟─4f2a3a8e-7012-4359-9b05-6b13b045540f
# ╟─5019d9f5-71c5-47bc-8286-9e02309b81eb
# ╟─54721e61-d21d-465f-953e-266c8c8e2d6e
# ╟─c0a70779-3e57-4b9f-a2df-70502de2b9c7
# ╟─a248aed1-b0b0-416d-93df-45831e692b7a
# ╟─6be45a6b-ce84-41f4-b1c9-90d8335431fe
# ╟─8231daaa-9f48-401b-abe1-550d9b4a8238
# ╟─f608f999-81a0-4ef3-aa1f-26bc225761bb
# ╟─1f883f87-d5fe-4e85-934f-48adce06f567
# ╟─bd2479e8-c8b6-42fc-a100-77035bad3f8e
# ╟─ec9f4678-7624-463d-97b5-c588d4ffab66
# ╟─dfbe1f84-782d-41e3-83e1-6aa1c9dd2029
# ╟─77a8fc85-cdbc-4f9d-9aed-13451c3182bd
# ╟─50a045a1-a9ff-4675-8fdb-a46b58e924d7
# ╟─4aed194d-ece6-4ce8-b2ea-552af91cb6e6
# ╟─93114ffd-0f8e-43b7-bd64-4859346448b1
# ╟─6dce2eb9-b96b-4fef-b213-1e5737b7b4a7
# ╟─2de777c0-91e0-405e-b048-221c344f98c4
# ╟─227bfc6a-7bce-438e-808f-22b0ab2f2e2e
# ╟─4b20021f-9293-4929-b354-b3073355ffea
# ╟─5f9bf960-ee0a-4aa1-bbae-2c69e923c745
# ╟─2d1768d1-bb1e-4e2e-8b4b-11d796f1379c
# ╟─70ddc2a0-047c-4f32-bb17-feaadf7df41e
# ╟─425dd22b-3872-45ec-a4f2-e2ba8d6d1eeb
# ╟─b857b5e2-176b-4faf-984b-e40f533e8d81
# ╟─89a9870f-2c6a-46c5-a9dc-5c0bfccf50a9
# ╟─92c0f101-c9fc-497d-92d2-3185d0a3559a
# ╟─3a4e02bc-a411-4a53-9199-85c8d9964f82
# ╟─b68a154b-48de-4978-b845-806cd245ca5d
# ╟─8391b8ab-58f6-4128-8f87-7eeca0fb211e
# ╟─753cdc33-d9a9-43b2-8d5d-61f64c0c6ae5
# ╟─cb0bad2c-aad2-449c-8c30-ae22a87e25f5
# ╟─72e6c5e3-8d5c-4893-a3a0-1e9e6559156e
# ╟─d0b8f53b-10ec-449e-80eb-50bdd46ecb5d
# ╟─1851e4aa-d15c-44bf-8052-f1dbc8bee02a
# ╟─50de31ac-e707-403c-960c-6121035b49f9
# ╟─618489c5-d824-4427-995d-103419c638cc
# ╟─29c1ea1f-7316-4d6e-83e1-4863c8e08dac
# ╟─8cb38b9f-b0f3-4e27-9d13-5a1e031ae472
# ╟─940007d8-3ef1-42cd-b29b-dd62e2693365
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
